push!(LOAD_PATH, "/home/yurimartins/Documentos/UFC/Topicos Avançados MI/Trabalho 3/modules/")

#using JuMP
#using Gurobi

import Data
import Formulations

instanceFile = "Trabalho 3 - Shortest Path Formulation/instances/sifaleras/52_1.txt"

inst = Data.readData(instanceFile)

Formulations.standardFormulation(inst)
