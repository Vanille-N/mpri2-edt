#import "typtyp.typ"
#let tt = typtyp

#let verif = rgb("b8bb26").lighten(70%)
#let prog = rgb("fe8019").lighten(60%)
#let logic = rgb("fabd2f").lighten(60%)
#let algos = rgb("d3869b").lighten(50%)
#let data = rgb("fb4934").lighten(50%)

#let Room = tt.typedef("Room", tt.content)
#let Class = tt.typedef("Class", tt.struct(name: tt.content, color: tt.color))
#let class(col, name) = {
  tt.is(tt.color, col)
  tt.is(tt.content, name)
  tt.ret(Class, ( name: name, color: col ))
}

// List of classes
#let proof_asst = class(verif)[Proof Assistants]
#let automata_mod = class(logic)[Automata Modelling]
#let symbolic_dyn = class(logic)[Symbolic Dynamics]
#let advanced_verif = class(verif)[Technics of Verification]
#let proof_systems = class(verif)[Foundations of Proof Systems]
#let algo_wqo = class(verif)[Well Quasi-Order Theory]
#let network_mod = class(logic)[Network Models]
#let biochem_prog = class(prog)[Biochemical Programming]
#let sync_sys = class(prog)[Synchronous Systems]
#let sec_protocols = class(verif)[Security Protocols]
#let lang_mod = class(data)[Natural Language Modelling]
#let graph_mining = class(data)[Graph Mining]
#let param_compl = class(algos)[Parameterized Complexity]
#let quantum_crypto = class(algos)[Quantum Cryptography]
#let linear_logic = class(logic)[Linear Logic]
#let poly_sys = class(algos)[Polynomial Systems]
#let cryptanalysis = class(algos)[Cryptanalysis]
#let error_corr = class(algos)[Error Correcting Codes]
#let da_networks = class(algos)[DA on Networks]
#let fp_and_types = class(prog)[FP and Type Systems]
#let combinatorics = class(algos)[Combinatorics]
#let analysis_algo = class(algos)[Analysis of Algorithms]
#let abstract_interp = class(verif)[Abstract Interpretation]
#let search_heuristics = class(data)[Search Heuristics]
#let geometric_graphs = class(algos)[Geometric Graphs]
#let topology = class(data)[Topology]
#let quantum_info = class(algos)[Quantum Information]
#let proba_prog = class(logic)[Probabilistic PL]
#let rand_compl = class(algos)[Randomness in Complexity]
#let comp_algebra = class(algos)[Computer Algebra]
#let graph_theory = class(data)[Graph Theory]
#let arith_crypto = class(algos)[Arithmetic for Cryptology]
#let concurrency = class(logic)[Concurrency]
#let uncertainty = class(data)[Alg. and Uncertainty]
#let proof_of_prog = class(verif)[Proof of Programs]
#let da_shared = class(algos)[DA on Shared Memory]
#let game_theory = class(logic)[Game Theory]
#let categories = class(logic)[Domains, Categories, Games]
#let algo_verif = class(verif)[Algorithmic Verification]
#let data_analysis = class(algos)[Data Analysis]

#let Time = tt.typedef("Time", tt.struct(tt.int, tt.int))
#let SemDescr = tt.typedef("SemDescr", tt.array(tt.int))
#let TimeClass = tt.typedef("TimeClass", tt.struct(descr: Class, room: Room, start: Time, len: Time, sem: SemDescr, ects: tt.int))
#let custom(descr, room, sem: none, start: none, len: none) = {
  tt.is(Class, descr)
  tt.is(Room, room)
  tt.is(Time, start)
  tt.is(Time, len)
  tt.is(SemDescr, sem)
  tt.ret(TimeClass, (
    descr: descr,
    room: room,
    sem: sem,
    ects: 6,
    start: start,
    len: len,
  ))
}

#let starting-times = ((8,45), (10,15), (12,45), (14,15), (16,15), (17,45))
#let full(period, descr, room, sem: (1,2)) = custom(descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2),
  len: (3,0),
)
#let short(period, slot, descr, room, sem: (1,2)) = custom(descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2 + slot - 1),
  len: (1,30),
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

