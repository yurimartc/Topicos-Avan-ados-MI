module Dantzig_relaxado

export dantzig_relaxado

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

    println( sum(x_solucao .* p) )
end
end
