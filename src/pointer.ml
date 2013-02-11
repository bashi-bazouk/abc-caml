
type 'a t = 'a option

let arr = Weak.create 1

let c_int p = Weak.set arr 0

let ( * ) ?t p =
  match (t, Weak.get arr p) with
    | (Some g, Some f) ->
      let gf x = g (f x) in
      Weak.set arr p (Some gf); gf
    | (Some g, None) ->
      Weak.set arr p (Some g); g
    | (None, Some f) -> f
    | (None, None) ->
      let id x = x in
      Weak.set arr p (Some id); id

