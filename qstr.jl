struct TimeEvent
  sp
  ep
end

time_event = TimeEvent(10,20)


# instances
eveA = TimeEvent(10,20)
eveB = TimeEvent(20,40)
eveC = TimeEvent(0,20)
eveD = TimeEvent(15,30)
eveE = TimeEvent(10,20)
eveF = TimeEvent(0,30)
eveG = TimeEvent(10,30)
eveH = TimeEvent(30,40)

function relation(X::TimeEvent, Y::TimeEvent)
  if (X.sp == Y.sp && X.ep == Y.ep)
    return "eq"
  elseif (X.ep < Y.sp)
    return "p"
  elseif (X.ep == Y.sp)
    return "m"
  elseif (X.ep > Y.sp && X.sp < Y.sp && X.ep < Y.ep)
    return "o"
  elseif (X.sp == Y.sp && X.ep <Y.ep)
    return "s"
  elseif (X.sp > Y.sp && X.ep < Y.ep && X.sp < Y.ep)
    return "d"
  elseif (X.sp > Y.sp && X.ep == Y.ep)
    return "f"
  # inverse
  elseif (Y.ep < X.sp)
    return "pi"
  elseif (Y.ep == X.sp)
    return "mi"
  elseif (Y.ep > X.sp && Y.sp < X.sp && Y.ep < X.ep)
    return "oi"
  elseif (Y.sp == X.sp && Y.ep <X.ep)
    return "si"
  elseif (Y.sp > X.sp && Y.ep < X.ep && Y.sp < X.ep)
    return "di"
  elseif (Y.sp > X.sp && Y.ep == X.ep)
    return "fi"
  else
    return "other"
  end
end

rel_dict = Dict([("p",1),("m",2),("o",3),("s",4),("d",5),
                 ("fi",6),("eq",7),("f",8),("di",9),("si",10),
                 ("oi",11),("mi",12),("pi",13)])

composition_table = 
  ["p" "p" "p" "p" "[p,d]" "p" "p" "[p,d]" "p" "p" "[p,d]" "[p,d]" "[p,pi]";
  "p" "p" "p" "m" "[o,d]" "p" "m" "[o,d]" "p" "m" "[o,d]" "[fi,f]" "[di,pi]";
  "p" "p" "[p,o]" "o" "[o,d]" "[p,o]" "o" "[o,d]" "[p,di]" "[o,di]" "[o,oi]" "[di,oi]" "[di,pi]";
  "p" "p" "[p,o]" "s" "d" "[p,o]" "s" "d" "[p,di]" "[s,si]" "[d,oi]" "mi" "pi";
  "p" "p" "[p,d]" "d" "d" "[p,d]" "d" "d" "1" "[d,pi]" "[d,pi]" "pi" "pi";
  "p" "m" "o" "o" "[o,d]" "fi" "fi" "[fi,f]" "di" "di" "[di,oi]" "[di,oi]" "[di,pi]";
  "p" "m" "o" "s" "d" "fi" "eq" "f" "di" "si" "oi" "mi" "pi";
  "p" "m" "[o,d]" "d" "d" "[fi,f]" "f" "f" "[di,pi]" "[oi,pi]" "[oi,pi]" "pi" "pi";
  "[p,di]" "[o,di]" "[o,d]" "[o,di]" "[o,oi]" "di" "di" "[di,oi]" "di" "di" "[di,oi]" "[di,oi]" "[di,pi]";
  "[p,di]" "[o,di]" "[o,di]" "[s,si]" "[d,oi]" "di" "si" "oi" "di" "si" "oi" "mi" "pi";
  "[p,di]" "[o,di]" "[o,oi]" "[d,oi]" "[d,oi]" "oi" "oi" "[di,pi]" "[oi,pi]" "[oi,pi]" "[oi,pi]" "pi" "pi";
  "[p,di]" "[s,si]" "[d,oi]" "[d,oi]" "[d,oi]" "mi" "mi" "mi" "pi" "pi" "pi" "pi" "pi";
  "[p,pi]" "[d,pi]" "[d,pi]" "[d,pi]" "[d,pi]" "pi" "pi" "pi" "pi" "pi" "pi" "pi" "pi"
  ]

inverse_dict = 
Dict([("p","pi"),("m","mi"),("o","oi"),("s","si"),("d","di"),("fi","f"),("eq","eq"),
  ("f","fi"),("di","d"),("si","s"),("oi","o"),("mi","m"),("pi","p")])

abbrev_dict =
Dict([("[p,o]", ["p","m","o"]),("[di,oi]", ["d","f","o")

function inverse(rel)
  return inverse_dict[rel]
end

function compose(rel1, rel2)
  return composition_table[rel_dict[rel1], rel_dict[rel2]]
end
