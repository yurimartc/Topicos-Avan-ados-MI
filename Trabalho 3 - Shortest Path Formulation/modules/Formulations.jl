module Formulations


using JuMP
using Gurobi
#import Data

mutable struct stdFormVars
  y_p
  y_r
  z_sp
  z_sr
  z_r
  l
end

export standardFormulation

#instanceFile = "/home/yurimartins/Documentos/UFC/Topicos Avançados MI/Trabalho 3/instances/sifaleras/52_1.txt"

#inst = Data.readData(instanceFile)

function standardFormulation(inst)

  NT = inst.N

  model = Model(Gurobi.Optimizer)


  ### variables ###
  @variable(model, y_p[t=1:NT], Bin) # números de items manufaturados no período t
  @variable(model, y_r[t=1:NT], Bin) # números de items remanufaturados no período t
  @variable(model,z_sp[i=1:NT, j=1:NT] >= 0) # Fração da demanda que será produzina no periodo i até j
  @variable(model,z_sr[i=1:NT, j=1:NT] >= 0) # Fração da demanda que será remanufaturada no periodo i até j
  @variable(model,z_r[i=1:NT, j=1:NT] >= 0) # Fração dos itens que serão retornadaos no periodo i até j e que será remanufaturada no periodo j
  @variable(model,l[i=1:NT]) # Fração dos itens que serão retornadaos no periodo i até NT

  ### objective function ###
#@objective(model, Min, sum(inst.F[t]*y_p[t] + inst.FR[t]*y_r[t] + l[t]*(sum(inst.HR[j]*sum(inst.D[k] for k in i:j) for j in t:NT)) for t in 1:NT) + sum(z_sp[i, j]*(inst.P[i]*sum(inst.D[k] for k in i:j) + sum(inst.H[t]*sum(inst.D[k] for k in t+1:j) for t in i:j-1)) +
#            z_sr[i, j]*(inst.PR[i]*sum(inst.D[k] for k in i:j) + sum(inst.HR[t]*sum(inst.D[k] for k in i:j) for t in i:j-1)) +
#            z_r[i, j]*(sum(inst.HR[t]*sum(inst.R[k] for k in i:t) for t in i:j-1)) for i in 1:NT for j in 1:NT))

  @objective(model, Min,
  sum(inst.F[t]*y_p[t] + inst.FR[t]*y_r[t] + (sum(inst.H[j]*sum(inst.D[k] for k in t:j) for j in t:NT)) for t in 1:NT) +
  sum(
  z_sp[i, j]*inst.P[i]*sum(inst.D[k] for k in i:j) + sum(inst.H[t]*sum(inst.D[k] for k in t+1:j) for t in i:j-1) +
  z_sr[i, j]*inst.PR[i]*sum(inst.D[k] for k in i:j) + sum(inst.H[t]*sum(inst.D[p] for p in t+1:j) for t in i:j-1) +
  z_r[i, j]*sum(inst.HR[t]*sum(inst.R[k] for k in i:t) for t in i:j-1) for i in 1:NT for j in 1:NT))


  ### constraints ###
  #Adicionando constantes

  #flow conservation constraints

  @constraint(model, conservasion1, sum(z_sp[1, j] + z_sr[1, j] for j in 1:NT) == 1) #10

  @constraint(model, conservasion2[t=2:NT], sum(z_sp[i, t-1] + z_sr[i, t-1] for i in 1:NT) == sum(z_sp[t, j] + z_sr[t, j] for j in 1:NT )) #11

  #setup enforcing constraints

  @constraint(model, setup_p[t=1:NT], y_p[t] >= sum(z_sp[t, j] for j in 1:NT)) #12

  @constraint(model, setup_r[t=1:NT], y_r[t] >= sum(z_sr[t, j] for j in 1:NT)) #13

  ## The shortest path constraints for the returned items

  #being flow conservation constraints
  @constraint(model, sp_conservasion1, sum(z_r[1, j] for j in 1:NT) + l[1] == 1) #14

  @constraint(model, sp_conservasion2[t=2:NT], sum(z_r[i, t-1] for i in 1:t-1) == sum(z_r[t, j] for j in 1:NT) + l[t]) #15

  #setup enforcing constraints

  @constraint(model, setupEnforcing[t=1:NT], sum(z_r[i, t] for i in 1:t) <= y_r[t]) #16

  #link the z r with the z sr variables
  
  @constraint(model, linkZvar[t=1:NT], sum(z_r[i, t] * sum(inst.R[p] for p in i:t) for i in 1:t) == sum(z_sr[t, j]* sum(inst.D[k] for k in t:j) for j in t:NT)) #17


  #write_to_file(model,"modelo.lp")

  ### solving the optimization problem ###
  optimize!(model)

  if termination_status(model) == MOI.OPTIMAL
    println("status = ", termination_status(model))
  else
    #error("O modelo não foi resolvido corretamente!")
    println("status = ", termination_status(model))
    return 0
  end

  ### get solutions ###
  bestsol = objective_value(model)

  time = solve_time(model)


end #function standardFormulation()

end
#standardFormulation(inst)
