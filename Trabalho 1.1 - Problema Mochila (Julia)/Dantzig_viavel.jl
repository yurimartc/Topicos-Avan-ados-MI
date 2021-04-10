module Dantzig_viavel

export dantzig_viavel

function dantzig_viavel(n, c, p, w)

    prop_p_n = p ./ w #Divisão da proporção entre a Matriz de pesos e capacidade
    idx_sort = sortperm(prop_p_n, rev=true) #Vetor de indices ordenados decrescente do vetor proporção
    c_atual = c #Capacidade atual da mochila
    x_solucao = zeros(Float64, n) #Vetor solução

    for i in idx_sort #Percorrer o vetor de indices
        if c_atual - w[i] < 0 #Se não tiver capacidade para colocar o item i
            x_solucao[i] = 0 #Atualizo vetor solução
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
