
globals [sequence]


  
to setup
  clear-all
 
  
  create-turtles num_items [set label who set shape "circle"] 
  ask turtles [ set color scale-color white who 0 num_items]
  
 
  set sequence [self] of turtles
  ask turtles [move-graphic]
  reset-ticks
end


to go
  tick
end



;;;;;;;;;;;;;;;;;;;

to move-graphic
  set xcor (position self sequence)
end


;;;;;;;;;;;;;;;;;;;

;to-report importance
;end
;
;
;; todo: use a percentage
;to-report satisfaction
;end




; If you think you are out of order relative to
; turtle ahead or behind, make the greedily optimal
; switch (pick the best of these two options). 
; Otherwise, do nothing.
; todo: VERIFY LENGTH 1, 2 CASES
to reorder
  ; prelim
  let n length sequence
  let i position self sequence

  
  ; before
  let preval -99
  if-else (i = 0) [
     stop ; temp
  ][
    let pre item (i - 1) sequence
    ask pre [set preval who]
  ]

  
  ; after
  let postval -99
  if-else (i = n - 1) [
    stop ; temp
  ][
    let post item (i + 1) sequence
    ask post [set postval who]
  ]
  
  
  ; fix whichever is worse (todo: improve this)
  let val who
  if not( preval <= val )            [swap i (i - 1) stop]
  if not(           val <= postval ) [swap i (i + 1) stop]
end

;;;;;;;;;;;;;;;;;;;

;
; side effect: changes sequence
;
to swap [i j] 
  if i < 0 [stop]
  if j < 0 [stop]
  if i > length sequence - 1 [stop]
  if j > length sequence - 1 [stop]

  let temp item j sequence
  set sequence replace-item j sequence (item i sequence)
  set sequence replace-item i sequence temp

  let p item i sequence
  let q item j sequence
  ask p [move-graphic]
  ask q [move-graphic]
end
