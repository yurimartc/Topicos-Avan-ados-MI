#Importanto funções criadas
from algoritmo_dantzig_relaxado import dantzit_relaxado
from algoritmo_dantzig_viavel import dantzit_viavel
from solucao_exata import solver_kp_problem
#Importando bibliotecas necessárias
import os
import pandas as pd


local = 'Trabalho 1 - Problema Mochila//instances_knapsack'

path = 'D://Yuri Drive//UFC//Topicos Avançados MI//Trabalho 1 - Problema Mochila//instances_knapsack//10//10_100_1.txt'

def read_instances_knapsack(path):
    """
    Retorna as variaveis da instancias do knapsack problem.

    :param path: string -> Caminho do arquivo onde se encontra a instancia em .txt \n \n

    :return (int, list, int, list) 
    """
    f = open(path, 'r') #Abrindo arquivo

    n = int(f.readline()) #Lendo e armazenando o tamanho da mochila
    space = f.readline()

    list_p = f.readline().split(' ') 
    p = []
    for i in list_p:    
        i = i.replace('\n', '')
        if i != '':
            p.append(int(i)) #Lendo e armazenando a Matriz de pesos            
    space = f.readline()

    c = int(f.readline()) #Lendo e armazenando capacidade da mochila
    space = f.readline()

    list_w = f.readline().split(' ')
    w = []
    for i in list_w:    
        i = i.replace('\n', '')
        if i != '':
            w.append(int(i)) #Lendo e armazenando a Matriz da capacidade
    f.close()

    return n, c, p, w

for dirpath, dirs, files in os.walk(local):
    for file in files:        
        if file.split('_')[0] == '200':
            local_file = local + '//' + file.split('_')[0] + '//' + file            
            n, c, p, w = read_instances_knapsack(local_file)
            print(f"Instancia -> {file}")
            print(f"{dantzit_viavel(n, c, p, w)} ----> dantzit_viavel")
            print(f"{dantzit_relaxado(n, c, p, w)} ----> dantzit_relaxado")
            print(f"{solver_kp_problem(n, c, p, w)} ----> solver_kp_problem")

