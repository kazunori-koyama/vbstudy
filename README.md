# vbstudy
ASP.NET MVC(VB)のテスト用

http://www.geocities.jp/ii2duck/personal/s1136_5.html


select * from (select t1.kanri_no
	    , sum(t1.keihi4) as keihi4
       , sum(t1.keihi5) as keihi5
       , sum(t1.keihi6) as keihi6
	   ,grouping(kanri_no) aaa
 from t_keihi t1
 group by ROLLUP([kanri_no])
 --order by 5 desc,1
 ) A
 left outer join t_keihi t2
 on A.kanri_no = t2.kanri_no
