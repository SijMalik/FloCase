select t.sp_name, sum(t.lines_of_code) - 1 as lines_ofcode
from (select o.name as sp_name, (len(c.text) - len(replace(c.text, char(10), ''))) as lines_of_code
from sysobjects o     
inner join syscomments c     
on c.id = o.id     
where o.xtype = 'P'     
and o.category = 0     
and o.name not in ('fn_diagramobjects', 'sp_alterdiagram', 'sp_creatediagram', 'sp_dropdiagram', 'sp_helpdiagramdefinition', 'sp_helpdiagrams', 'sp_renamediagram', 'sp_upgraddiagrams', 'sysdiagrams') ) t 
group by t.sp_name 
order by t.sp_name