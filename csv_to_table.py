import csv
import sqlalchemy as sa
from sqlalchemy import create_engine, engine
from sqlalchemy import text
import comments_config_constants as cfg_const
import comments_config as cfg
import logging
# import logging_init as li
import pandas as pd
import sys
import os
import getopt

DEFAULT_LOGGER = 'crs-dev'
USER_ID = 'BOARD\M1KRR01'
 
QUESTIONS = '../../seperated_question_list.csv'
COMMENTERS = '../../commenters_list.csv'
CP_ID = 8
sa.url = cfg.get_sqlalchemy_url(cfg.get_database_type_by_env()) 

def read_input(argv):
    q, c = '',''
    arg_help = "{0} -q <questions> -c <commenters> -p <path>".format(argv[0])
    
    try:
        opts, args = getopt.getopt(argv[1:], "hq:c:", ["help", "q=", "c="])
    except:
        print(arg_help)
        sys.exit(2)
    
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(arg_help)  # print the help message
            sys.exit(2)
        elif opt in ("-q", "--question", "--questions"):
            q = arg
        elif opt in ("-c", "--commenter", "--commenters"):
            c = arg

    if not q:
        q = QUESTIONS 
    if not c:
        c = COMMENTERS 

    return q, c

def read_csv_to_list(file: str):
    lst = []
    with open(file, newline='', encoding='utf-8') as fl:
        reader = csv.reader(fl, delimiter=',', quotechar='"')
        for row in reader:      
            lst.append(GlobalLabel(cp_id, row[0], row[1]))
    return lst

def read_csv_to_list_multiline(file: str, col_list: list=[], col_fmt: list=[], userid: int=None):
    columns = col_list # ["cp_id", "label_name", "description", "user_id"]
    colfmt = col_fmt # ['{0}','Question {0}','{0}','{0}']
    lst = []
    with open(file, newline='', encoding='utf-8') as fl:
        reader = csv.reader(fl, delimiter=',', quotechar='"')
        for row in reader:      
            lst.append([colfmt[0].format(CP_ID), colfmt[1].format(row[0]), colfmt[2].format(row[1]), colfmt[3].format(userid)])
    df = pd.DataFrame(lst)
    df.columns = columns        
    print(df.columns)    
     
    df['label_description'] = df.groupby(["label_name"])["description"].transform(lambda x : '\n'.join(x))
    dfnew = df.drop(["description"], axis=1)
    dfnew = dfnew.drop_duplicates()   
    print(dfnew)
    return dfnew

def get_label_maxid(engine: engine):
    stmt = f"select max(convert(int,replace(label_name,'question ', ''))) as num from dbo.cra_label where label_name like 'Question%[0-9]%'"
    maxid = engine.execute(stmt).first()
    print(f'Max ID: {maxid}')
    if not maxid or maxid[0] is None:
        return 0
    else: 
        return maxid['num']

def get_user_id(eng: engine, usrid: str=USER_ID) -> int:
    check_stmt = f"SELECT TOP (1) [id] FROM [dbo].[cra_user_info] where [user_id] = nullif('{usrid}','')"
    res = eng.execute(check_stmt).first()
    print(f'RES: {res}')
    if res:
        uid = res['id']
    else:
        uid=None
    return uid

def upload_labels_df(df: pd.DataFrame, eng: engine, check_col: str, maxid: str=''):
    results = []
    if len(df) == 0:
        print('No labels to load')
    else:
        df = df.reset_index()  # make sure indexes pair with number of rows
        usr_id = get_user_id(eng, USER_ID)
        print(f"USER_ID: {usr_id}")
        # maxid = get_label_maxid(engine=eng)
        # n = maxid + 1

        for index, row in df.iterrows():
            check_stmt = f"select top (1) id from dbo.cra_label where {check_col} = '{row[f'{check_col}']}'"
            print(check_stmt)
            res = eng.execute(check_stmt).first()
            cp_id = CP_ID # row['cp_id']            

            label_name = row['label_name']
            label_description = row['label_description']
            is_global = 1 # row['is_global']
            if not res:
                print(f"None: {check_col}")
                stmt = f"""insert dbo.cra_label (cp_id, label_name, label_description,is_global,user_id) 
                values({cp_id},'{label_name}','{label_description}',{is_global},{usr_id})"""
                try:
                    eng.execute(stmt)
                    msg = f'{index}: Created: {check_col}' 
                except:
                    msg = f'{index}: Failed to create: {check_col}'   
                    print(stmt)                 
            else:
                msg = f'Exists {res[0]}: {check_col}'
            results.append(msg)
            # n += 1
    return results

def file_to_table(file: str, columns: list=[], colfmt: list=[], check_col: str='label_name'):
    eng = sa.create_engine(sa.url, echo=True)
    userid = get_user_id(eng=eng, usrid=USER_ID)
    df = read_csv_to_list_multiline(file=file, col_list=columns, col_fmt=colfmt)
    results = upload_labels_df(df=df, eng=eng, check_col=check_col)
    for res in results:
        print(res)

def main():
    # li.initialize_logger()    
    questions, commenters = read_input(sys.argv)    
    # eng = sa.create_engine(sa.url, echo=True)
    if USER_ID is None:
        print('User is None')
        
    print('questions:', questions)
    print('commenters:', commenters)
    
    columns = ["cp_id", "label_name", "description","user_id"]
    colfmt = ['{0}','Question {0}','{0}','{0}']
    
    file_to_table(file=questions, columns=columns, colfmt=colfmt, check_col='label_description')

    colfmt = ['{0}','{0}','{0}','{0}']
    file_to_table(commenters, columns=columns, colfmt=colfmt, check_col='label_name')

if __name__ == '__main__':

    main()

 
