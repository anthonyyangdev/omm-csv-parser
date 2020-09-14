(** [section_index header] is possibly the index of the section value in the
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
  (* [filter_fun student] returns [true] if index [section_index] of
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

module StringMap = Map.Make(String)

(** [options map] is the list of CLI options and specifications for
    [Arg.parse].
*)
let options map: (string * Arg.spec * string) list =
  let add_input = fun i -> map := StringMap.add "i" i !map in
  let add_section = fun s -> map := StringMap.add "s" s !map in
  let add_output = fun o -> map := StringMap.add "o" o !map in
  [
    ("-i", Arg.String add_input, "The input csv from Canvas");
    ("-s", Arg.String add_section, "The section number");
    ("-o", Arg.String add_output, "The output file")
  ]

(** [main ()] begins the program. *)
let main () =
  let map = ref (StringMap.singleton "o" "omm.csv") in
  Arg.parse (options map) (fun i -> map := StringMap.add "i" i !map) "";
  try
    let filename = StringMap.find "i" !map in
    let section = StringMap.find "s" !map |> int_of_string in
    let output = StringMap.find "o" !map in
    let filtered = filter filename section in
    Csv.save output filtered
  with
  | Not_found -> print_endline "Not all arguments are given."
  | Failure _ -> print_endline "Invalid integer given for section."

let () = main()