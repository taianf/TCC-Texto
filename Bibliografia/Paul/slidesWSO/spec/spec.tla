---------------------- MODULE Spec ----------------------
SendElem(t) ==
    /\ Shared.medium = {}
    /\ Shared.chipTimer = 0
    /\ LET i == taskId(t)
           flag == IF ProcState[i].list # << >> THEN 1 ELSE 0
       IN /\ Shared.chipCount = i
          /\ LET resSet == reservation(i) 
             IN /\ Shared' = [ Shared EXCEPT 
                       !.macTimer = delta,
                       !.medium = { [ id |-> i, type |-> "hard",
                                      res |-> resSet, procFlag |-> flag ] } ]
                /\ TaskState' = [ TaskState EXCEPT
                       ![i].res = [ j \in Task |-> IF j \in resSet THEN i ELSE @[j] ],
                       ![i].cons = 1 ]
                /\ ProcState' = [ ProcState EXCEPT
                       ![i].token = IF flag = 0 THEN -1 ELSE @ ]
                /\ History' = [ History EXCEPT !.elem = @ + 1 ]
=====================================
