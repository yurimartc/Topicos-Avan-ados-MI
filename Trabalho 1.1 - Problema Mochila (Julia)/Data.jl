module Data

struct InstanceData
  N::Int #numero de itens
  P # beneficio dos itens
  C::Int # capacidade da mochila
  W # peso dos itens
end

export InstanceData, readData

function readData(instanceFile)
  file = open(instanceFile)
  fileText = read(file, String)
  tokens = split(fileText)
  #tokens will have all the tokens of the input file in a single vector. We will get the input token by token

  # read the problem's dimensions N
  aux = 1
  N = parse(Int,tokens[aux])

  #resize data structures according to N
  P = zeros(Float64,N)
  W = zeros(Float64,N)


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

  close(file)

  open("saida.txt","a") do f
    write(f,"$instanceFile")
  end

  inst = InstanceData(N, P, C, W)

  return inst

end

end
