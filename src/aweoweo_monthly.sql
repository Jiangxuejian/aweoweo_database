today=$(date +'%Y%m')

mysql -h omp1 -u staff -b -p -e "select utdate, obsnum, project, object,
file_id, msbtitle, obs_sb, jcmt.ACSIS.subsysnr, subbands, jcmt.ACSIS.restfreq,
molecule, transiti
from jcmt.ACSIS join jcmt.COMMON on jcmt.ACSIS.obsid=jcmt.COMMON.obsid
join jcmt.FILES on jcmt.ACSIS.obsid_subsysnr=jcmt.FILES.obsid_subsysnr
where jcmt.COMMON.telescop='JCMT'
and instrume = 'Aweoweo'  and utdate >= 20210501 and utdate <20210601
order by utdate, obsnum ASC ;" > aweoweo_sql_${today}.tsv
