#Bibliotecas necessárias
import numpy as np
import gurobipy as gb
from gurobipy import GRB


"""
# ==== Dados exemplo ====
n = 7 #Tamanho da mochila
p = [6, 5, 8, 9, 6, 7, 3] #Matriz de pesos
w = [2, 3, 6, 7, 5, 9, 3] #Matriz da capacidade
c = 9 #Capacidade total da mochila
"""
def solver_kp_problem(n, c, p, w):
    """
    Retorna o vetor solução e valor da função objetivo do problema da mochila viavel.

    :param n: integer -> Tamanho da mochila \n
    :param c: integer -> Capacidade total da mochila \n
    :param p: array -> Matriz de pesos \n
    :param w: array -> Matriz da capacidade\n \n

    :return (array, float) 
    """
    m = gb.Model() #Criando o modelo    
    m.Params.LogToConsole = 0 #Parametro para não printar informações do solver
    x = m.addVars(n, vtype=GRB.BINARY, name='x') #Adicionando Variáveis    
    m.addConstr((x.prod(w)) <= c, name='mochila') #Adicionando Restrições
    m.setObjective(x.prod(p), GRB.MAXIMIZE) #Adicionando a Função Objetivo    
    m.optimize() #Resolvendo o problema

    x_solucao = [] #Vetor de solulçao
    for v in m.getVars(): #Percorrendo cada variável trazendo seu valor
        x_solucao.append(v.x)

    return m.objVal

#print(solver_kp_problem(n, c, p, w))