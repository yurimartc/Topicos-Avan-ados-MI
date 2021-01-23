\ Model minimum_cost_flow
\ LP format - for model browsing. Use MPS format to capture full model detail.
Minimize
  2 x[0,1] + 5 x[0,2] + 3 x[1,2] + x[2,3] + 2 x[3,4] + 4 x[4,1]
Subject To
 cap[0,1]: x[0,1] <= 10
 cap[0,2]: x[0,2] <= 10
 cap[1,2]: x[1,2] <= 10
 cap[2,3]: x[2,3] <= 10
 cap[2,5]: x[2,5] <= 10
 cap[3,0]: x[3,0] <= 10
 cap[3,4]: x[3,4] <= 10
 cap[4,1]: x[4,1] <= 10
 flow[0]: x[0,1] + x[0,2] - x[3,0] = -5
 flow[1]: - x[0,1] + x[1,2] - x[4,1] = 10
 flow[2]: - x[0,2] - x[1,2] + x[2,3] + x[2,5] = 0
 flow[3]: - x[2,3] + x[3,0] + x[3,4] = -2
 flow[4]: - x[3,4] + x[4,1] = -3
Bounds
End
