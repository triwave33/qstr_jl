# qstr_jl

QSTR (stands for Qualitative Spatio Temporal Reasoning) deals with relationships between two objects (or events) against spatial and/or temporal directions.

## Temporal domain

For this repository, an event is always represented as "interval" way. That is, each event has its start- and end-points.

e.g. event "A" started at t=10 and ended at t=20. This is represented as A(10,20).

Considering two time-events, say A(10,20) and B(30,40), one can say "B precedes A" because B starts after A ends. So this is the one example of the relations defined by Allen's interval algebla.

## Allen's interval algebra

There is 13 relations between two time-events in Allen's interval algebra.

1. precedes (symboled as 'p')
2. meets ('m')
3. overlaps ('o')
4. starts ('s')
5. during ('d')
6. finishes ('f')
7. equals ('eq')

and their inverse functions for 1-6.

These 13 relations are exclusive, and covers all time domains (that is, any relation between two time-events corresponds one of these 13 relations).

for graphical explanation see https://en.wikipedia.org/wiki/Allen%27s_interval_algebra

## Composition (transition) of relations

The one of the merits of QSTR is "deducing (or entailing) relations which does not explicitly indicated by observed time events. In other words, we can get more information than time events which are directly observed.

The simplest way is "precedes of precedes is precedes". Supposed that we obtained data (relation between two time-events) for event A and B described below.

- relation(A, B) => "precedes"
- relation(B, C) => "precedes"

Intutively, we can deduce relation(A,C) => "precedes". This turn to be correct when considering specific values for A,B and C. 
  e.g. A(10,20), B(30,40), C(55, 70)

This kind of composition (chain rule) is also extended other relations. Compositions from 13 relations to 13 relations are examined. And results are known as composition table (13x13 matrix correspongs rel1->rel2)

NOTE: Trainsitive relation from rel1 to rel2 is not always determined as an unique relation. For example, 
relation(A,B) => 'precedes' (B occurs after A occurs)
relation(B,C) => 'during' (B occurs during C occurs)

In this case, relation(A,C) may be 'precedes' or 'meets' or 'overlaps' or 'starts' or 'during'. We have to get further informtion if we want to know relation(A,C) in detail.

  
### so what?

Now we understand the concept. But what for does qstr exist? or what is the merit of qstr? Sometimes we can get more information from two relations. But so what? The examples above are too simple. The merits are



