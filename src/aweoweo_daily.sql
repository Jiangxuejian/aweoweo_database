today=$(date '+%Y%m%d')

mysql -h omp1 -u staff -b -p -e "select utdate, obsnum, project, object,
msbtitle, obs_sb, jcmt.ACSIS.subsysnr, subbands, jcmt.ACSIS.lofreqs, jcmt.ACSIS.restfreq,
molecule, transiti, tau225st, file_id 
from jcmt.ACSIS
join jcmt.COMMON on jcmt.ACSIS.obsid=jcmt.COMMON.obsid
join jcmt.FILES on jcmt.ACSIS.obsid_subsysnr=jcmt.FILES.obsid_subsysnr
where jcmt.COMMON.telescop='JCMT'
and instrume = 'Aweoweo'  and utdate=$today;" > aweoweo_sql_${today}.tsv
