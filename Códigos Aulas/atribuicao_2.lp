\ Model Atribuicao
\ LP format - for model browsing. Use MPS format to capture full model detail.
Maximize
  53 x[Carlos,Cientista] + 27 x[Carlos,Desenvolvedor]
   + 13 x[Carlos,Arquiteto] + 80 x[Jonas,Cientista]
   + 47 x[Jonas,Desenvolvedor] + 67 x[Jonas,Arquiteto]
   + 53 x[Monica,Cientista] + 73 x[Monica,Desenvolvedor]
   + 47 x[Monica,Arquiteto] + 100 x[Ana,_Cientista]
   + 100 x[Ana,_Desenvolvedor] + 100 x[Ana,_Arquiteto]
Subject To
 trabalho[Cientista]: x[Carlos,Cientista] + x[Jonas,Cientista]
   + x[Monica,Cientista] + x[Ana,_Cientista] = 1
 trabalho[Desenvolvedor]: x[Carlos,Desenvolvedor] + x[Jonas,Desenvolvedor]
   + x[Monica,Desenvolvedor] + x[Ana,_Desenvolvedor] = 1
 trabalho[Arquiteto]: x[Carlos,Arquiteto] + x[Jonas,Arquiteto]
   + x[Monica,Arquiteto] + x[Ana,_Arquiteto] = 1
 pessoa[Carlos]: x[Carlos,Cientista] + x[Carlos,Desenvolvedor]
   + x[Carlos,Arquiteto] <= 1
 pessoa[Jonas]: x[Jonas,Cientista] + x[Jonas,Desenvolvedor]
   + x[Jonas,Arquiteto] <= 1
 pessoa[Monica]: x[Monica,Cientista] + x[Monica,Desenvolvedor]
   + x[Monica,Arquiteto] <= 1
 pessoa[Ana]: x[Ana,_Cientista] + x[Ana,_Desenvolvedor] + x[Ana,_Arquiteto]
   <= 1
Bounds
Binaries
 x[Carlos,Cientista] x[Carlos,Desenvolvedor] x[Carlos,Arquiteto]
 x[Jonas,Cientista] x[Jonas,Desenvolvedor] x[Jonas,Arquiteto]
 x[Monica,Cientista] x[Monica,Desenvolvedor] x[Monica,Arquiteto]
End
