using PackageCompiler

create_sysimage([:JuMP,:Gurobi]; sysimage_path="sysimage.dylib",
precompile_execution_file="/home/yurimartins/Documentos/UFC/Topicos Avançados MI/Trabalho 3/modules/shortest_path_formulation.jl")
