(** [section_index header[] is possibly the index of the section value in the
    Csv downloaded from Canvas's OMM module.
*)
let section_index header =
  let rec helper index = function
    | [] -> None
    | h::t -> 
      if String.trim h = "section" then Some index
      else helper (index + 1) t
  in helper 0 header


(** [filter_csv students section_index section] is [students] filtered by
    [section], where the student's section is found in index [section_index]
    for each student in [students].
*)
let filter_csv students section_index section =
  (** [filter_fun student] returns [true] if index [section_index] of
      [student] has the substring ["DIS" ^ string_of_int section].
  *)
  let filter_fun student =
    let section_cell = List.nth student section_index in
    let regex = Str.regexp_string ("DIS" ^ string_of_int section) in
    try ignore(Str.search_forward regex section_cell 0); true
    with Not_found -> false
  in List.filter filter_fun students


(**
   [filter filename discussion] is a filtered list of rows, where each row is
   a list of columns, of students who are in [section] from [filename] csv
   downloaded from Canvas's OMM module.
*)
let filter filename section =
  let csv = Csv.load filename in
  (* List of rows, for each row is a list of columns *)
  match csv with
  | [] -> raise (Invalid_argument ("Empty csv"))
  | header::students ->
    let index = section_index header in
    match index with
    | None -> raise (Invalid_argument("Csv does not contain sections."))
    | Some i -> header::(filter_csv students i section)

(** [main ()] begins the program. *)
let main () =
  let filename = Sys.argv.(1) in
  let section = Sys.argv.(2) |> int_of_string in
  let output = Sys.argv.(3) in
  let filtered = filter filename section in
  Csv.save output filtered

let () = main()