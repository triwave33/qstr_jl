
################ instances for test #################
using .qstr_util
using Printf
eveA = timeevent(10,20)
eveB = timeevent(20,40)
eveC = timeevent(0,20)
eveD = timeevent(15,30)
eveE = timeevent(10,20)
eveF = timeevent(0,30)
eveG = timeevent(10,30)
eveH = timeevent(30,40)

println("######## test suite ##########")
println("relation between eventA and eventB should be 'm'")
tAB = make_triple(eveA, eveB)  # make triple <s, p, o>
@printf("relAB: %s", tAB.p)
println()
println("OK")
println()

println("relation between eventB and eventC should be 'mi'")
tBC = make_triple(eveB, eveC)  # make triple <s, p, o>
@printf("relBC: %s", tBC.p)
println()
println("OK")
println()
println("Now calculating composition relAC =  relAB -> relBC")
tAC = triple(eveA, compose(tAB.p[1], tBC.p[1]), eveC)
@printf("relAC: %s", tAC.p) 
println()

println("####### OVERALL TEST ##########")
for pair_1 in rel_dict
  for pair_2 in rel_dict
    compose_rel = abbrev_dict[composition_table[rel_dict[pair_1[1]], rel_dict[pair_2[1]]]]
    @printf("%s & %s => %s", pair_1[1], pair_2[1], compose_rel)
    println()
  end
  println()
end

