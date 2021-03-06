type t

type selections

type diagnostics

val create :
  ?prefer_oldest:bool ->
  constraints:(Cudf_types.pkgname * (Cudf_types.relop * Cudf_types.version)) list ->
  Cudf.universe ->
  t
(** [create ~constraints universe] is a solver that gets candidates from [universe],
    filtering them using [constraints].

    @param prefer_oldest if [true] the solver is set to return the least
    up-to-date version of each package, if a solution exists. This is [false] by
    default. @before 0.4 the [prefer_oldest] parameter did not exist. *)

val solve :
  t ->
  (Cudf_types.pkgname * [`Essential | `Recommended]) list ->
  (selections, diagnostics) result
(** [solve t packages] finds a compatible set of package versions that
    includes all packages in [packages] according to their requirement tag,
    and their required dependencies if needed. *)

val packages_of_result : selections -> (Cudf_types.pkgname * Cudf_types.version) list

val diagnostics : ?verbose:bool -> diagnostics -> string
(** [diagnostics d] is a message explaining why [d] failed, generated by
    performing another solve which doesn't abort on failure. *)
