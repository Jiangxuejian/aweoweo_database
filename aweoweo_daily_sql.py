import pexpect, keyring
from datetime import datetime
from os import path
import pandas as pd

omppwd = keyring.get_password('ompsql', 'staff')

sql_file = 'aweoweo_daily.sql'

p=['sh', './aweoweo_daily.sql']
child = pexpect.spawn(' '.join(p), cwd='./')

child.expect('Enter password:')
child.sendline(omppwd)
child.wait()


today = datetime.today().strftime('%Y%m%d')

sql_result = 'aweoweo_sql_'+today+'.tsv'
f1=pd.read_csv(sql_result, sep='\t')
df = pd.DataFrame(columns=['path'])
j=-1
for i in range(0,len(f1)):
        date= str(f1['utdate'][i])
        num = format(f1['obsnum'][i], '05d')
        filter = f1['file_id'][i][:3]
        filename = f1['file_id'][i]
        #if f1['subsysnr'][i] == 1:    # only keep subsysnr=1 data
        datapath = path.join('/jcmtdata/raw/acsis/spectra/', date, num, filename)
        if path.isfile(datapath):
            j=j+1
            df.loc[j] = datapath
files = pd.DataFrame(pd.unique(df.path))
files.to_csv('aweoweo_file_'+today+'.txt', index=False, header=False)


