----------------------------------- MODULE doris -----------------------------------------
(***************************************************************************************)
(*  This is the list of actions that may be enabled                                     *)
(***************************************************************************************)
SendHardMsg(id, list) == \* Task "id" sends a slot message with a reservation list.
SendHardMsg(id)       == \* Task "id" sends a slot message (reservation message).
SendBestMsg(id, s)    == \* Process "id" sends a best effort message of size s
SendStopMsg(id, next) == \* Process "id" sends a STOP message to reserve the token
                         \* for process "next"
UpdateCounter(id)     == \* The local counter K[id] is incremented by 1.
UpdateTimer(t, id)    == \* Reset t[id] to 0
UpdateGamma(id)       == \* Update the Gamma tuple when receiving an elementary
                         \* message with a reservation list
UpdateState(id, bool) == \* Update the state variable to the value bool
ReceiveHardMsg(id)    == \* Task id receives a slot message 
ReceiveBestMsg(id)    == \* Process id receives a best effort message
ReceiveStopMsg(id)    == \* Process id receives a STOP message 
                         \* and update his local counter
-----------------------------------------------------------------------------------------
Timeout(id)           == /\ esTimer[id] = Delta_es
                         /\ UpdateCounter(id)
                         /\ UpdateTimer(esTimer, id)
               
ElementaryWindow(id) ==  /\ 0 =< t[id] < d 
                         /\ IF K[id] = id
                            THEN 
                               /\ list == IF state
                                          THEN \* reservation list for the next cycle
                                          ELSE \* { -1 }
                               /\ SendHardMsg(id, list)
                            ELSE
                               /\ ReceiveHardMsg(id)
                               /\ IF \* elementary message arrives
                                  THEN 
                                     /\ UpdateGamma(id)
                                     /\ UpdateState(id, true)
                                  ELSE UpdateState(id, false)

ReservationWindow(id) == /\ delta + d  =< t[id] < delta + 2 * d 
                         /\ IF K[id] = Gamma[id]
                            THEN SendHardMsg(id)
                            ELSE ReceiveHardMsg(id)

BestEffortWindow(id)  == /\ 2 * ( delta + d ) < t[id] < Delta_es
                         /\ IF t[id] < 3 * delta
                            THEN IF \* the MAC is iddle
                                 THEN
                                    /\ beTimer(id) = d
                                    /\ UpdateTimer(beTimer, id)
                                    /\ UpdateCounter(id)
                                    /\ IF K[id] = id
                                       THEN IF \* Process id has "data" to transmit
                                            THEN IF t[id] - sizeOf(data) > 3 *d
                                                 THEN SendBestMsg(id, sizeOf(data))
                                                 ELSE SendStopMsg(id, id)
                                            ELSE \* do nothing (loop)
                                       ELSE \* do nothing (loop)  
                                 ELSE 
                                    /\ UpdateTimer(beTimer, id)
                                    /\ ReceiveBestMsg(id)
                                    /\ \* wait for EOF interrupt 
                            ELSE 
                               IF K[id] = id
                               THEN IF \* Process id has "data" to transmit
                                    THEN SendStopMsg(id, id)
                                    ELSE SendStopMsg(id, id + 1)
                               ELSE
                                  /\ ReceiveStopMsg(id)
=======================================================================================