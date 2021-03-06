--Q1
select numero_departamento, round(avg(salario),2) as média_salarial 
from funcionario 
group by numero_departamento order by numero_departamento;

--Q2
select sexo, round(avg(salario),2) as média_salarial 
from funcionario  
group by sexo;

--Q3
select  concat(primeiro_nome, nome_meio, ultimo_nome) as nome_completo, 
	data_nascimento, 
	year(current_timestamp())-year(data_nascimento) as idade, 
        salario, 
        d.nome_departamento 
from funcionario f 
inner join departamento d on (f.numero_departamento = d.numero_departamento);

--Q4
select distinct concat(f1.primeiro_nome, f1.nome_meio, f1.ultimo_nome) as nome_completo, 
		year(current_timestamp())-year(f1.data_nascimento) as idade, 
		f1.salario as salaraio_atual,
		if(f2.salario >= 35000, f2.salario * 1.15, f2.salario * 1.20) as salario_reajustado
from funcionario f1
inner join funcionario f2 on (f1.cpf = f2.cpf);

--Q5
select distinct f1.primeiro_nome as funcionario, f2.primeiro_nome as gerente, d.nome_departamento, f1.salario 
from funcionario f1
inner join funcionario f2 
on (f1.cpf_supervisor = f2.cpf)
inner join departamento d 
on (f1.numero_departamento = d.numero_departamento)
order by nome_departamento, salario desc;

--Q6
select distinct concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento, 
		concat(d.nome_dependente, f.nome_meio, f.ultimo_nome) as nome_dependente, 
                year(current_timestamp())-year(d.data_nascimento) as idade_dependente, 
                if(d.sexo = "M","Masculino","Feminino") as sexo
from funcionario f
inner join dependente d on (f.cpf = d.cpf_funcionario);

--Q7
select concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_completo, f.salario,  depar.nome_departamento 
from funcionario f 
inner join departamento depar ON (depar.numero_departamento = f.numero_departamento) 
left join dependente depen ON (depen.cpf_funcionario = f.cpf) 	
where depen.nome_dependente IS null;

--Q8
select distinct numero_departamento, 
		trabalha_em.numero_projeto, 
                concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_funcionario,
                horas
from funcionario f
inner join trabalha_em on (f.cpf = trabalha_em.cpf_funcionario) 
order by numero_departamento;

--Q9
select sum(t.horas) as horas_totais, nome_projeto, nome_departamento 
from trabalha_em t  
inner join projeto p on (p.numero_projeto = t.numero_projeto) 
inner join departamento d on (d.numero_departamento = p.numero_departamento)
where t.numero_projeto = t.numero_projeto  
group by t.numero_projeto, p.nome_projeto, d.nome_departamento;

--Q10
select numero_departamento, round(avg(salario),2) as média_salarial 
from funcionario 
group by numero_departamento order by numero_departamento;

--Q11
select  concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_funcionario, 
	p.nome_projeto,(te.horas * 50) as valor
from funcionario f 
inner join trabalha_em te on (f.cpf = te.cpf_funcionario)
inner join projeto p on (p.numero_projeto = te.numero_projeto);

--Q12
select  concat(primeiro_nome, nome_meio, ultimo_nome) as funcionario, 
	d.nome_departamento, p.nome_projeto, 
        horas 
from departamento d 
inner join projeto p on (d.numero_departamento = p.numero_departamento) 
inner join trabalha_em t on (t.numero_projeto = p.numero_projeto) 
inner join funcionario f on (t.cpf_funcionario = f.cpf) 
where t.horas = 0;

--Q13
select distinct concat(primeiro_nome, nome_meio, ultimo_nome) as nome, sexo, year(current_timestamp())-year(data_nascimento) as idade
from funcionario
union
select distinct concat(d.nome_dependente, f.nome_meio, f.ultimo_nome) as nome, d.sexo, year(current_timestamp())-year(d.data_nascimento) as idade
from dependente d
inner join funcionario f on (f.cpf = d.cpf_funcionario)
order by idade desc;

--Q14
select f.numero_departamento, count(*) as qnt_empregados 
from funcionario f, departamento d
where f.numero_departamento = d.numero_departamento
group by f.numero_departamento;

--Q15
select distinct concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_completo, f.numero_departamento, p.nome_projeto
from funcionario f
inner join trabalha_em te on (f.cpf = te.cpf_funcionario)
left outer join projeto p on (p.numero_projeto = te.numero_projeto and f.cpf = te.cpf_funcionario and te.horas > 0)
order by nome_projeto;
