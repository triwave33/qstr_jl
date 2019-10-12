# qstr_jl

QSTR (stands for Qualitative Spatio Temporal Reasoning) deals with relationships between two objects (or events) against spatial and/or temporal direction.

## Temporal domain

For this repository, an event are always represent as "interval" way. That is, each event has its start- and end-point.

e.g. a certain time-event "A" started at t=10 and ended at t=20. This is represented as A(10,20).

Considering two time-event, say A(10,20) and B(30,40), one can say "B precedes A" because B starts after A ends. So this is the one of the relation for temoral domain by Allen's interval algebla.

## Allen's interval algebra

There is a 13 relation for two time-events in Allen's interval algebra.

1. precedes (symboled as 'p')
2. meets ('m')
3. overlaps ('o')
4. starts ('s')
5. during ('d')
6. finishes ('f')
7. equals ('eq')

and inverse functions fo 1-6.

These 13 relations are exclusive, and covers all time domain (that is, any relation between two time-events corresponds one of these 13 relations).

for graphical explanation see https://en.wikipedia.org/wiki/Allen%27s_interval_algebra

## Composition (transition) of relations

The merit
