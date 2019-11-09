module qstr_util 

export timeevent, triple # struct
export rel_dict, composition_table, abbrev_dict, inverse_dict # variables (dictionaries)
export relation, inverse, make_triple, compose # function

####### struct ###########
struct timeevent
    sp::Float64
    ep::Float64
end

struct triple
    s::timeevent      # subject
    p::Array{String}  # predicate
    o::timeevent      # object
end


####### variables ################

# map from relation (aka predicate)  to index number
rel_dict = Dict([("p",1),("m",2),("o",3),("s",4),("d",5),
                 ("fi",6),("eq",7),("f",8),("di",9),("si",10),
                 ("oi",11),("mi",12),("pi",13)])

# transitive relation map rel(a,c) = rel(a,b) -> rel(b,c)
composition_table = 
  ["p" "p" "p" "p" "[p,d]" "p" "p" "[p,d]" "p" "p" "[p,d]" "[p,d]" "[p,pi]";
  "p" "p" "p" "m" "[o,d]" "p" "m" "[o,d]" "p" "m" "[o,d]" "[fi,f]" "[di,pi]";
  "p" "p" "[p,o]" "o" "[o,d]" "[p,o]" "o" "[o,d]" "[p,di]" "[o,di]" "[o,oi]" "[di,oi]" "[di,pi]";
  "p" "p" "[p,o]" "s" "d" "[p,o]" "s" "d" "[p,di]" "[s,si]" "[d,oi]" "mi" "pi";
  "p" "p" "[p,d]" "d" "d" "[p,d]" "d" "d" "[p,pi]" "[d,pi]" "[d,pi]" "pi" "pi";
  "p" "m" "o" "o" "[o,d]" "fi" "fi" "[fi,f]" "di" "di" "[di,oi]" "[di,oi]" "[di,pi]";
  "p" "m" "o" "s" "d" "fi" "eq" "f" "di" "si" "oi" "mi" "pi";
  "p" "m" "[o,d]" "d" "d" "[fi,f]" "f" "f" "[di,pi]" "[oi,pi]" "[oi,pi]" "pi" "pi";
  "[p,di]" "[o,di]" "[o,d]" "[o,di]" "[o,oi]" "di" "di" "[di,oi]" "di" "di" "[di,oi]" "[di,oi]" "[di,pi]";
  "[p,di]" "[o,di]" "[o,di]" "[s,si]" "[d,oi]" "di" "si" "oi" "di" "si" "oi" "mi" "pi";
  "[p,di]" "[o,di]" "[o,oi]" "[d,oi]" "[d,oi]" "oi" "oi" "[di,pi]" "[oi,pi]" "[oi,pi]" "[oi,pi]" "pi" "pi";
  "[p,di]" "[s,si]" "[d,oi]" "[d,oi]" "[d,oi]" "mi" "mi" "mi" "pi" "pi" "pi" "pi" "pi";
  "[p,pi]" "[d,pi]" "[d,pi]" "[d,pi]" "[d,pi]" "pi" "pi" "pi" "pi" "pi" "pi" "pi" "pi"
  ]


# map from abbreviated notation to multi relations in composition table
abbrev_dict =
    Dict([("p",["p"]),("m",["m"]),("o",["o"]),("s",["s"]),("d",["d"]),
          ("fi",["fi"]),("eq",["eq"]),("f",["f"]),("di",["di"]),("si",["si"]),
          ("oi",["oi"]),("mi",["mi"]),("pi",["pi"]),
          ("[p,o]", ["p","m","o"]),("[d,oi]", ["d","f","oi"]),
          ("[o,oi]",["o","s","d","fi","eq","f","di","si","oi"]),
          ("[oi,pi]", ["oi","mi","pi"]),
          ("[p,d]",["p","m","o","s","d"]),
          ("[d,pi]",["d","f","oi","mi","pi"]),
          ("[o,d]",["o","s","d"]),
          ("[fi,f]",["fi","eq","f"]),
          ("[p,di]",["p","m","o","fi","di"]),
          ("[s,si]",["s","eq","si"]),
          ("[di,pi]",["di","si","oi","mi","pi"]),
          ("[p,pi]",["p","m","o","s","d","fi","eq","f","di","si","oi","mi","pi"]),
          ("[o,di]",["o","fi","di"]),
          ("[di,oi]",["di","si","oi"])
          ])

# simple mapping to inverse function
inverse_dict = 
    Dict([("p","pi"),("m","mi"),("o","oi"),("s","si"),("d","di"),("fi","f"),("eq","eq"),
    ("f","fi"),("di","d"),("si","s"),("oi","o"),("mi","m"),("pi","p")])

############## function ####################
function relation(X::timeevent, Y::timeevent)
    if (X.sp == Y.sp && X.ep == Y.ep)
        return ["eq"]
    elseif (X.sp < X.ep < Y.sp < Y.ep)
        return ["p"]
    elseif (X.sp < X.ep == Y.sp < Y.ep)
        return ["m"]
    elseif (X.sp < Y.sp < X.ep < Y.ep)
        return ["o"]
    elseif (X.sp == Y.sp <  X.ep <Y.ep)
        return ["s"]
    elseif (Y.sp < X.sp < X.ep < Y.ep)
        return ["d"]
    elseif (Y.sp < X.sp < X.ep == Y.ep)
        return ["f"]
    # inverse
    elseif (X.sp < X.ep < Y.sp < Y.ep)
        return ["pi"]
    elseif (Y.sp < Y.ep == X.sp < X.ep)
        return ["mi"]
    elseif (Y.sp < X.sp < Y.ep < X.ep)
        return ["oi"]
    elseif (Y.sp == X.sp < Y.ep < X.ep)
        return ["si"]
    elseif (X.sp < Y.sp < Y.ep < X.ep)
        return ["di"]
    elseif (X.sp < Y.sp < Y.ep == X.ep)
        return ["fi"]
    else
        return ["other"]
    end
end

function inverse(rel)
  #input
  return inverse_dict[rel]
end

function make_triple(te1, te2)
  #input 
  # te1: timeevent1, te2: timeevent2
  return triple(te1, relation(te1, te2), te2)
end

function compose(p1::String, p2::String)
  return abbrev_dict[composition_table[rel_dict[p1], rel_dict[p2]]]
end
end # module end 



