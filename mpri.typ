#import "typtyp.typ"
#let tt = typtyp
#import "time.typ"

#let verif = rgb("b8bb26").lighten(70%)
#let prog = rgb("fe8019").lighten(60%)
#let logic = rgb("fabd2f").lighten(60%)
#let algos = rgb("d3869b").lighten(50%)
#let data = rgb("fb4934").lighten(50%)

#let Room = tt.typedef("Room", tt.content)
#let Class = tt.typedef("Class", tt.struct(name: tt.content, color: tt.color, uid: tt.content, teacher: tt.content))
#let class(col, name, uid, teacher) = {
  tt.is(tt.color, col)
  tt.is(tt.content, name)
  tt.is(tt.content, uid)
  tt.is(tt.content, teacher)
  tt.ret(Class, ( name: name, color: col, uid: uid, teacher: teacher ))
}

// List of classes
#let proof_asst = class(verif)[Proof Assistants][2.7.2][Winterhalter]
#let automata_mod = class(logic)[Automata Modelling][2.16][Picantin]
#let symbolic_dyn = class(logic)[Symbolic Dynamics][2.20.2][Berthé]
#let advanced_verif = class(verif)[Technics of Verification][2.8][Bouyer]
#let proof_systems = class(verif)[Foundations of Proof Systems][2.7.1][Dowek]
#let algo_wqo = class(verif)[Well Quasi-Order Theory][2.9.1][Finkel]
#let network_mod = class(logic)[Network Models][2.17.1][Mairesse]
#let biochem_prog = class(prog)[Biochemical Programming][2.19][Fages]
#let sync_sys = class(prog)[Synchronous Systems][2.23][Pouzet]
#let sec_protocols = class(verif)[Security Protocols][2.30][Blanchet]
#let lang_mod = class(data)[Natural Language Modelling][2.27.1][Schmitz]
#let graph_mining = class(data)[Graph Mining][2.29.2][Sozio]
#let param_compl = class(algos)[Parameterized Complexity][2.11.1][Mitsou]
#let quantum_crypto = class(algos)[Quantum Cryptography][2.34.2][Chailloux]
#let linear_logic = class(logic)[Linear Logic][2.1][Kesner]
#let poly_sys = class(algos)[Polynomial Systems][2.13.1][Faugère]
#let cryptanalysis = class(algos)[Cryptanalysis][2.12.1][Minaud]
#let error_corr = class(algos)[Error Correcting Codes][2.13.1][Faugère]
#let da_networks = class(algos)[DA on Networks][2.18.1][Fraigniaud]
#let fp_and_types = class(prog)[FP and Type Systems][2.4][Pottier]
#let combinatorics = class(algos)[Combinatorics][2.10][Schaeffer]
#let analysis_algo = class(algos)[Analysis of Algorithms][2.15][Ravelomanana]
#let abstract_interp = class(verif)[Abstract Interpretation][2.6][Miné]
#let search_heuristics = class(data)[Search Heuristics][2.24.2][Doerr]
#let geometric_graphs = class(algos)[Geometric Graphs][2.38.1][Laplante]
#let topology = class(data)[Topology][2.14.1][Glisse]
#let quantum_info = class(algos)[Quantum Information][2.34.1][Laplante]
#let proba_prog = class(logic)[Probabilistic PL][2.40][Tasson]
#let rand_compl = class(algos)[Randomness in Complexity][2.11.2][Magniez]
#let comp_algebra = class(algos)[Computer Algebra][2.22][Chyzak]
#let graph_theory = class(data)[Graph Theory][2.29.1][Naserasr]
#let arith_crypto = class(algos)[Arithmetic for Cryptology][2.12.2][Smith]
#let concurrency = class(logic)[Concurrency][2.3.1][Haucourt]
#let uncertainty = class(data)[Alg. and Uncertainty][2.24.1][Angelopoulos]
#let proof_of_prog = class(verif)[Proof of Programs][2.36.1][Marché]
#let da_shared = class(algos)[DA on Shared Memory][2.18.2][Delporte]
#let game_theory = class(logic)[Game Theory][2.20.1][Zielonka]
#let categories = class(logic)[Domains, Categories, Games][2.2][Melliès]
#let algo_verif = class(verif)[Algorithmic Verification][2.9.2][Bouajjani]
#let data_analysis = class(algos)[Data Analysis][2.39][Tierny]

#let SemDescr = tt.typedef("SemDescr", tt.array(tt.int))
#let TimeClass = tt.typedef("TimeClass", tt.struct(
  descr: Class,
  room: Room,
  start: time.Time,
  len: time.Time,
  sem: SemDescr,
  ects: tt.int,
))
#let custom(descr, room, sem: none, start: none, len: none, ects: none) = {
  tt.is(Class, descr)
  tt.is(Room, room)
  tt.is(time.Time, start)
  tt.is(time.Time, len)
  tt.is(SemDescr, sem)
  tt.is(tt.int, ects)
  tt.ret(TimeClass, (
    descr: descr,
    room: room,
    sem: sem,
    ects: ects,
    start: start,
    len: len,
  ))
}

#let starting-times = ((8,45), (10,15), (12,45), (14,15), (16,15), (17,45)).map(t => time.from-hm(..t))
#let full(period, descr, room, sem: (1,2)) = custom(descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2),
  len: time.from-hm(3, 0),
  ects: 3 * sem.len(),
)
#let short(period, slot, descr, room, sem: (1,2)) = custom(descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2 + slot - 1),
  len: time.from-hm(1, 30),
  ects: 3,
)

// Static timetable
#let Day = tt.typedef("Day", tt.struct(name: tt.str, classes: tt.array(TimeClass)))
#let Week = tt.typedef("Week", tt.struct(mon: Day, tue: Day, wed: Day, thu: Day, fri: Day))
#let week = tt.ret(Week, (
  mon: (
    name: "Monday",
    classes: (
      full(1, sem:(1,), proof_asst)[1002],
      full(1, automata_mod)[1004],
      short(2, 1, symbolic_dyn)[1002],
      full(2, advanced_verif)[1004],
      full(3, sem:(1,), proof_systems)[1004],
      full(3, sem:(1,), algo_wqo)[1002],
      full(3, sem:(2,), network_mod)[1002],
      full(3, sem:(2,), biochem_prog)[1004],
    ),
  ),
  tue: (
    name: "Tuesday",
    classes: (
      full(1, sem:(1,), sync_sys)[1004],
      full(1, sec_protocols)[1002],
      full(2, sem:(1,), lang_mod)[1004],
      full(2, sem:(1,), graph_mining)[1002],
      full(2, sem:(2,), param_compl)[1002],
      full(2, sem:(2,), quantum_crypto)[1004],
      full(3, linear_logic)[1002],
      full(3, sem:(1,), poly_sys)[1004],
    ),
  ),
  wed: (
    name: "Wednesday",
    classes: (
      short(1, 1, cryptanalysis)[1004],
      short(1, 2, error_corr)[1004],
      short(1, 2, da_networks)[1002],
      full(2, fp_and_types)[1002],
      full(2, combinatorics)[1004],
      full(2, analysis_algo)[1002],
    ),
  ),
  thu: (
    name: "Thursday",
    classes: (
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
  ),
  fri: (
    name: "Friday",
    classes: (
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
  ),
))

