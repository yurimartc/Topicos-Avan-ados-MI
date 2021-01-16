#Bibliotecas necessárias
import numpy as np
"""
# ==== Dados exemplo ====
n = 7 #Tamanho da mochila
p = [6, 5, 8, 9, 6, 7, 3] #Matriz de pesos
w = [2, 3, 6, 7, 5, 9, 3] #Matriz da capacidade
c = 9 #Capacidade total da mochila
"""
def dantzit_relaxado(n, c, p, w):
    """
    Retorna o vetor solução e valor da função objetivo do problema da mochila relaxado.

    :param n: integer -> Tamanho da mochila \n
    :param c: integer -> Capacidade t   otal da mochila \n
    :param p: array -> Matriz de pesos \n
    :param w: array -> Matriz da capacidade\n \n

    :return (array, float) 
    """
    prop_p_n = np.divide(p, w) #Divisão da proporção entre a Matriz de pesos e capacidade
    idx_sort = np.argsort(prop_p_n, kind='mergesort')[::-1] #Vetor de indices ordenados decrescente do vetor proporção
    c_atual = c #Capacidade atual da mochila
    x_solucao = np.zeros(n) #Vetor solução

    for i in idx_sort: #Percorrer o vetor de indices
        if c_atual - w[i] < 0: #Se não tiver capacidade para colocar o item i
            x_h = c_atual/w[i] #Calculamos o valor da solução x_h
            x_solucao[i] = x_h #Atualizo vetor solução
            break
        if c_atual - w[i] >= 0: #Se tiver capacidade para colocar o item i
            c_atual = c_atual - w[i] #Atualizo a capacidade atual
            x_solucao[i] = 1 #Atualizo vetor solução
            
    return sum(x_solucao*p) 

#print(dantzit_relaxado(n, c, p, w))