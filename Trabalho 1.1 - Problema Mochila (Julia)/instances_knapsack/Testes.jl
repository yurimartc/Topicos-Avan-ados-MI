
instanceFile = "/home/yurimartins/Documentos/Topicos-Avancados-MI/Trabalho 1.1 - Problema Mochila (Julia)/instances_knapsack/10/10_100_5.txt"

file = open(instanceFile)
fileText = read(file, String)
tokens = split(fileText)

N = parse(Int, tokens[1])


P = zeros(Float64,N)
W = zeros(Float64,N)

aux = 1

for p in 1:N
  aux = aux+1
  P[p] = parse(Int,tokens[aux])
end

aux = aux+1
C = parse(Int, tokens[aux])

for w in 1:N
  aux = aux+1
  W[w] = parse(Int,tokens[aux])
end

readline()
print(N)
readline()
print(P)
readline()
print(C)
readline()
print(W)
readline()



function dantzig_relaxado(n, c, p, w)

    p = p
    prop_p_n = p ./ w #Divisão da proporção entre a Matriz de pesos e capacidade
    idx_sort = sortperm(prop_p_n, rev=true) #Vetor de indices ordenados decrescente do vetor proporção
    c_atual = c #Capacidade atual da mochila
    x_solucao = zeros(Float64, n) #Vetor solução

    for i in idx_sort #Percorrer o vetor de indices
        if c_atual - w[i] < 0 #Se não tiver capacidade para colocar o item i
            x_h = c_atual ./ w[i] #Calculamos o valor da solução x_h
            x_solucao[i] = x_h #Atualizo vetor solução
            break
        end
        if c_atual - w[i] >= 0 #Se tiver capacidade para colocar o item i
            c_atual = c_atual - w[i] #Atualizo a capacidade atual
            x_solucao[i] = 1 #Atualizo vetor solução
        end
    end

    println(sum(x_solucao .* p))
end
dantzig_relaxado(N, C, P, W)
