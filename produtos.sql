select
  p.codint as codigo
, p.codint as codigo_anterior
, p.codint as anterior
, p.codoriginal as ref_produto_auxiliar
, p.codfor as ref_produto_fornec
, p.codbarra as codigo_barras_temp
, p.outroscodigo as aplicacao2
, p.descricao
, p.aplicacao as aplicacao1
, m.descricao as marca     
, p.fornecedor as codigo_forncedor_anterior
, p.unidade as medida
, g.descricao as secao
, sg.descricao as grupo

, lpad(coalesce(nullif(p.st,''),'000'),3,'0') as cst
/*, p.cf as ncm
, p.cest as cest
, p.tributacao
, p.icms*/
, iif(p.tributacao = 'T','000','060') as cst
, iif(p.tributacao = 'T','000','060') as cst_nfc
, iif(p.tributacao = 'T','000','060') as cst_interestadual

, iif(p.tributacao = 'T','0102','0500') as csosn
, iif(p.tributacao = 'T','0102','0500') as csosn_nfc
, iif(p.tributacao = 'T','0102','0500') as csosn_interestadual

, iif(p.tributacao = 'T',8,1) as codigo_tributo
, iif(p.tributacao = 'T',5102,5405) as codigo_cfop_nfc
, 1 as codigo_tributo_pis_entrada
, 1 as codigo_tributo_pis_saida
, 2 as codigo_tributo_cofins_entrada
, 2 as codigo_tributo_cofins_saida
, '99' as cst_pis
, '99' as cst_cofins
, '99' as cst_pis_entrada
, '99' as cst_cofins_entrada

, iif(p.custo > 0,p.custo,0.00) as f_custo_reposicao
, iif(p.custototal > 0,p.custototal,0.00) as f_custo_medio
, iif(p.custototal > 0,p.custototal,0.00) as custo_medio
, iif(p.custototal > 0,p.custototal,0.00) as f_pmz
, iif(p.precovenda > 0,p.precovenda,0.00) as preco_venda
, iif(p.precovenda > 0,p.precovenda,0.00) * 0.90 as f_preco_venda_minimo
, iif(p.percentualvenda > 0,p.percentualvenda,0.00) as f_lucro

, coalesce(p.locrua,'')
|| ' - ' || coalesce(p.locprateleira,'')
|| ' - ' || coalesce(p.locbandeja,'')
|| ' - ' || coalesce(p.locposicao,'') as localizacao

, coalesce(p.qtdisponivel,0.00) as estoque
, iif(p.qtminima > 0,p.qtminima,0.00) as estoque_minimo

from itm p
left join marca m
  on m.codigo = p.marca

left join grp g
  on g.codigo = p.codgrp

left join subgrp sg
  on sg.codigo = p.codsubgrp
  --and sg.grupo <> p.codgrp


where p.codint=27


order by
  p.codint