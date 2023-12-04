-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Sobre o Conjunto de Dados
-- MAGIC ### Quais Fatores Afetam os Preços de Computadores Portáteis?
-- MAGIC * Vários fatores podem afetar os preços de computadores portáteis. Esses fatores incluem a marca do computador e o número de opções e complementos incluídos no pacote do computador. Além disso, a quantidade de memória e a velocidade do processador também podem afetar os preços. Embora menos comum, alguns consumidores gastam dinheiro adicional para comprar um computador com base no "visual" geral e no design do sistema.
-- MAGIC * Em muitos casos, computadores de marcas conhecidas são mais caros do que versões genéricas. Esse aumento de preço muitas vezes está mais relacionado ao reconhecimento da marca do que a qualquer superioridade real do produto. Uma grande diferença entre sistemas de marca e genéricos é que, na maioria dos casos, os computadores de marca oferecem garantias melhores do que as versões genéricas. Ter a opção de devolver um computador com mau funcionamento muitas vezes é incentivo suficiente para encorajar muitos consumidores a gastar mais dinheiro.
-- MAGIC * A funcionalidade é um fator importante na determinação dos preços de computadores portáteis. Um computador com mais memória muitas vezes tem um desempenho melhor por mais tempo do que um computador com menos memória. Além disso, o espaço no disco rígido também é crucial, e o tamanho do disco rígido geralmente afeta os preços. Muitos consumidores também podem procurar drivers de vídeo digital e outros tipos de dispositivos de gravação que podem afetar os preços de computadores portáteis.
-- MAGIC * A maioria dos computadores vem com algum software pré-instalado. Na maioria dos casos, quanto mais software estiver instalado em um computador, mais caro ele será. Isso é especialmente verdadeiro se os programas instalados forem de editoras de software bem estabelecidas e reconhecíveis. Aqueles que estão pensando em comprar um novo computador portátil devem estar cientes de que muitos dos programas pré-instalados podem ser apenas versões de avaliação e expirarão dentro de um determinado período de tempo. Para manter os programas, será necessário comprar um código e, em seguida, baixar uma versão permanente do software.
-- MAGIC * Muitos consumidores que estão comprando um novo computador estão adquirindo um pacote completo. Além do próprio computador, esses sistemas geralmente incluem um monitor, teclado e mouse. Alguns pacotes podem até incluir uma impressora ou câmera digital. O número de extras incluídos em um pacote de computador geralmente afeta os preços de computadores portáteis.
-- MAGIC * Algumas empresas líderes na fabricação de computadores destacam-se ao oferecer computadores com design elegante e em uma variedade de cores. Elas também podem oferecer design de sistema incomum ou contemporâneo. Embora isso seja menos importante para muitos consumidores, para aqueles que valorizam a estética, esse tipo de sistema pode valer a pena o custo extra.
-- MAGIC
-- MAGIC ### De onde obtive esses dados?
-- MAGIC * Obtive esses dados diretamente do Kaggle. 
-- MAGIC * Você pode encontrar o conjunto de dados mais recente sobre a lista de preços de laptops no seguinte link: https://www.kaggle.com/datasets/kuchhbhi/latest-laptop-price-list

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # About Dataset
-- MAGIC ### What Factors Affect Laptop Computer Prices?
-- MAGIC * Several different factors can affect laptop computer prices. These factors include the brand of computer and the number of options and add-ons included in the computer package. In addition, the amount of memory and the speed of the processor can also affect pricing. Though less common, some consumers spend additional money to purchase a computer based on the overall “look” and design of the system.
-- MAGIC * In many cases, name brand computers are more expensive than generic versions. This price increase often has more to do with name recognition than any actual superiority of the product. One major difference between name brand and generic systems is that in most cases, name brand computers offer better warranties than generic versions. Having the option of returning a computer that is malfunctioning is often enough of an incentive to encourage many consumers to spend more money.
-- MAGIC * Functionality is an important factor in determining laptop computer prices. A computer with more memory often performs better for a longer time than a computer with less memory. In addition, hard drive space is also crucial, and the size of the hard drive usually affects pricing. Many consumers may also look for digital video drivers and other types of recording devices that may affect the laptop computer prices.
-- MAGIC * Most computers come with some software pre-installed. In most cases, the more software that is installed on a computer, the more expensive it is. This is especially true if the installed programs are from well-established and recognizable software publishers. Those considering purchasing a new laptop computer should be aware that many of the pre-installed programs may be trial versions only, and will expire within a certain time period. In order to keep the programs, a code will need to be purchased, and then a permanent version of the software can be downloaded.
-- MAGIC -Many consumers who are purchasing a new computer are buying an entire package. In addition to the computer itself, these systems typically include a monitor, keyboard, and mouse. Some packages may even include a printer or digital camera. The number of extras included in a computer package usually affects laptop computer prices.
-- MAGIC * Some industry leaders in computer manufacturing make it a selling point to offer computers in sleek styling and in a variety of colors. They may also offer unusual or contemporary system design. Though this is less important to many consumers, for those who do value “looks,” this type of system may be well worth the extra cost.
-- MAGIC
-- MAGIC ### From where I did get this data?
-- MAGIC I obtained this data directly from Kaggle. You can find the latest laptop price list dataset at the following link: https://www.kaggle.com/datasets/kuchhbhi/latest-laptop-price-list
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # Análise descritiva (SQL)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Exploração/desenvolvimento

-- COMMAND ----------

/* Criando visualização
Convertendo preço de Rúpia Indiana para Real
Corrigindo desconto */
alter view vw_laptop_sales 
as
select *, 
(latest_price * 0.063) as latest_price_real,
(old_price * 0.063) as old_price_real,
(discount / 100) as new_discount
from projetos.default.laptop_sales;

-- COMMAND ----------

select * from vw_laptop_sales;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Média de preços das marcas

-- COMMAND ----------

select 
case when brand = 'lenovo' then 'Lenovo' 
  else brand
end as new_brand,
avg(latest_price_real) as avg_latest_price

from vw_laptop_sales

group by 
case when brand = 'lenovo' then 'Lenovo' 
  else brand
end

order by avg_latest_price desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Participação das memórias (DDR3, DDR4, DDR5)

-- COMMAND ----------

select 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type in ('LPDDR4', 'LPDDR4X') then 'DDR4'
     else ram_type 
end as new_ram_type,
avg(latest_price_real) as avg_latest_price

from vw_laptop_sales

group by 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type in ('LPDDR4', 'LPDDR4X') then 'DDR4'
     else ram_type 
end

order by avg_latest_price desc

-- COMMAND ----------

select 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type in ('LPDDR4', 'LPDDR4X') then 'DDR4'
     else ram_type 
end as new_ram_type,
sum(latest_price_real) as sum_latest_price

from vw_laptop_sales

group by 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type in ('LPDDR4', 'LPDDR4X') then 'DDR4'
     else ram_type 
end

order by sum_latest_price desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Média de preços por marca de processador

-- COMMAND ----------

select 
processor_brand,
avg(latest_price_real) as avg_latest_price
from vw_laptop_sales
group by 
processor_brand
order by avg_latest_price desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Média de preços se possui ou não Touchscreen
-- MAGIC

-- COMMAND ----------

select 
Touchscreen,
avg(latest_price_real) as avg_latest_price
from vw_laptop_sales
group by 
Touchscreen
order by avg_latest_price desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Participação de processadores Intel Core (i3, i5, i7, i9)

-- COMMAND ----------

select 
processor_name,
avg(latest_price_real) as avg_latest_price
from vw_laptop_sales
where processor_name like '%Core%'
group by 
processor_name
order by avg_latest_price desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC    
