push!(LOAD_PATH, "/home/yurimartins/Documentos/Topicos-Avancados-MI/Trabalho 1.1 - Problema Mochila (Julia)/")


import Data
import Dantzig_relaxado
import Dantzig_viavel

instanceFile = "/home/yurimartins/Documentos/Topicos-Avancados-MI/Trabalho 1.1 - Problema Mochila (Julia)/instances_knapsack/10/10_100_5.txt"

inst = Data.readData(instanceFile)

Dantzig_relaxado.dantzig_relaxado(inst.N, inst.C, inst.P, inst.W)
Dantzig_viavel.dantzig_viavel(inst.N, inst.C, inst.P, inst.W)
