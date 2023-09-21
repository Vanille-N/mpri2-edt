#import "typtyp.typ"
#let tt = typtyp
#import "time.typ"
#import "classes.typ"

// Re-exports for backwards compatibility
#let Class = classes.Class

#let verif = rgb("b8bb26").lighten(70%)
#let prog = rgb("fe8019").lighten(60%)
#let logic = rgb("fabd2f").lighten(60%)
#let algos = rgb("d3869b").lighten(50%)
#let data = rgb("fb4934").lighten(50%)

#let fmt(name, uid, teacher, room) = [
  #{ // UID is mandatory for MPRI classes
    assert(uid != none)
  }
  #text(size: 11pt, weight: "bold")[#name] \
  #text(size: 11pt)[Room #room]
  #text(size: 8pt)[(#teacher)]
  #text(size: 8pt, weight: "bold")[[#uid]]
]

// List of classes
#let proof_asst        = classes.new(verif, fmt, [Proof Assistants],             [2.7.2],  [Winterhalter])
#let automata_mod      = classes.new(logic, fmt, [Automata Modelling],           [2.16],   [Picantin])
#let symbolic_dyn      = classes.new(logic, fmt, [Symbolic Dynamics],            [2.20.2], [Berthé])
#let advanced_verif    = classes.new(verif, fmt, [Technics of Verification],     [2.8],    [Bouyer])
#let proof_systems     = classes.new(verif, fmt, [Foundations of Proof Systems], [2.7.1],  [Dowek])
#let algo_wqo          = classes.new(verif, fmt, [Well Quasi-Order Theory],      [2.9.1],  [Finkel])
#let network_mod       = classes.new(logic, fmt, [Network Models],               [2.17.1], [Mairesse])
#let biochem_prog      = classes.new(prog,  fmt, [Biochemical Programming],      [2.19],   [Fages])
#let sync_sys          = classes.new(prog,  fmt, [Synchronous Systems],          [2.23],   [Pouzet])
#let sec_protocols     = classes.new(verif, fmt, [Security Protocols],           [2.30],   [Blanchet])
#let lang_mod          = classes.new(data,  fmt, [Natural Language Modelling],   [2.27.1], [Schmitz])
#let graph_mining      = classes.new(data,  fmt, [Graph Mining],                 [2.29.2], [Sozio])
#let param_compl       = classes.new(algos, fmt, [Parameterized Complexity],     [2.11.1], [Mitsou])
#let quantum_crypto    = classes.new(algos, fmt, [Quantum Cryptography],         [2.34.2], [Chailloux])
#let linear_logic      = classes.new(logic, fmt, [Linear Logic],                 [2.1],    [Kesner])
#let poly_sys          = classes.new(algos, fmt, [Polynomial Systems],           [2.13.1], [Faugère])
#let cryptanalysis     = classes.new(algos, fmt, [Cryptanalysis],                [2.12.1], [Minaud])
#let error_corr        = classes.new(algos, fmt, [Error Correcting Codes],       [2.13.1], [Faugère])
#let da_networks       = classes.new(algos, fmt, [DA on Networks],               [2.18.1], [Fraigniaud])
#let fp_and_types      = classes.new(prog,  fmt, [FP and Type Systems],          [2.4],    [Pottier])
#let combinatorics     = classes.new(algos, fmt, [Combinatorics],                [2.10],   [Schaeffer])
#let analysis_algo     = classes.new(algos, fmt, [Analysis of Algorithms],       [2.15],   [Ravelomanana])
#let abstract_interp   = classes.new(verif, fmt, [Abstract Interpretation],      [2.6],    [Miné])
#let search_heuristics = classes.new(data,  fmt, [Search Heuristics],            [2.24.2], [Doerr])
#let geometric_graphs  = classes.new(algos, fmt, [Geometric Graphs],             [2.38.1], [Laplante])
#let topology          = classes.new(data,  fmt, [Topology],                     [2.14.1], [Glisse])
#let quantum_info      = classes.new(algos, fmt, [Quantum Information],          [2.34.1], [Laplante])
#let proba_prog        = classes.new(logic, fmt, [Probabilistic PL],             [2.40],   [Tasson])
#let rand_compl        = classes.new(algos, fmt, [Randomness in Complexity],     [2.11.2], [Magniez])
#let comp_algebra      = classes.new(algos, fmt, [Computer Algebra],             [2.22],   [Chyzak])
#let graph_theory      = classes.new(data,  fmt, [Graph Theory],                 [2.29.1], [Naserasr])
#let arith_crypto      = classes.new(algos, fmt, [Arithmetic for Cryptology],    [2.12.2], [Smith])
#let concurrency       = classes.new(logic, fmt, [Concurrency],                  [2.3.1],  [Haucourt])
#let uncertainty       = classes.new(data,  fmt, [Alg. and Uncertainty],         [2.24.1], [Angelopoulos])
#let proof_of_prog     = classes.new(verif, fmt, [Proof of Programs],            [2.36.1], [Marché])
#let da_shared         = classes.new(algos, fmt, [DA on Shared Memory],          [2.18.2], [Delporte])
#let game_theory       = classes.new(logic, fmt, [Game Theory],                  [2.20.1], [Zielonka])
#let categories        = classes.new(logic, fmt, [Domains, Categories, Games],   [2.2],    [Melliès])
#let algo_verif        = classes.new(verif, fmt, [Algorithmic Verification],     [2.9.2],  [Bouajjani])
#let data_analysis     = classes.new(data,  fmt, [Data Analysis],                [2.39],   [Tierny])

#let starting-times = ((8,45), (10,15), (12,45), (14,15), (16,15), (17,45)).map(t => time.from-hm(..t))

#let full(period, descr, room, sem: (1,2)) = classes.slot(
  descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2),
  len: time.from-hm(3, 0),
  ects: 3 * sem.len(),
)
#let short(period, slot, descr, room, sem: (1,2)) = classes.slot(
  descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2 + slot - 1),
  len: time.from-hm(1, 30),
  ects: 3,
)

#let later(minutes, class) = {
  tt.is(classes.TimeClass, class)
  class.start = time.offset(class.start, time.from-hm(0, minutes))
  class
}

// Static timetable
#let week = tt.ret(classes.Week, (
  mon: (
    full(1, sem:(1,), proof_asst)[1002],
    full(1, automata_mod)[1004],
    short(2, 1, symbolic_dyn)[1002],
    full(2, advanced_verif)[1004],
    full(3, sem:(1,), proof_systems)[1004],
    full(3, sem:(1,), algo_wqo)[1002],
    full(3, sem:(2,), network_mod)[1002],
    full(3, sem:(2,), biochem_prog)[1004],
  ),
  tue: (
    full(1, sem:(1,), sync_sys)[1004],
    full(1, sec_protocols)[1002],
    full(2, sem:(1,), lang_mod)[1004],
    full(2, sem:(1,), graph_mining)[1002],
    full(2, sem:(2,), param_compl)[1002],
    full(2, sem:(2,), quantum_crypto)[1004],
    full(3, linear_logic)[1002],
    full(3, sem:(1,), poly_sys)[1004],
  ),
  wed: (
    short(1, 1, cryptanalysis)[1004],
    short(1, 2, error_corr)[1004],
    later(15, short(1, 2, da_networks)[1002]),
    full(2, fp_and_types)[1002],
    full(2, combinatorics)[1004],
    full(2, analysis_algo)[1002],
  ),
  thu: (
    full(1, abstract_interp)[1004],
    full(1, sem:(2,), search_heuristics)[1002],
    full(1, sem:(1,), geometric_graphs)[1002],
    full(2, sem:(1,), topology)[1002],
    full(2, sem:(1,), quantum_info)[1004],
    full(2, sem:(2,), proba_prog)[1002],
    full(3, sem:(1,), rand_compl)[1002],
    full(3, comp_algebra)[1004],
    full(3, sem:(2,), graph_theory)[1002],
  ),
  fri: (
    full(1, sem:(1,), arith_crypto)[1004],
    full(1, sem:(2,), concurrency)[1002],
    full(1, sem:(1,), uncertainty)[1002],
    full(1, sem:(2,), proof_of_prog)[1004],
    full(2, sem:(1,), da_shared)[1002],
    full(2, sem:(1,), game_theory)[1004],
    full(3, categories)[1004],
    full(3, sem:(2,), algo_verif)[1002],
    full(3, sem:(1,), data_analysis)[1002],
  ),
))

