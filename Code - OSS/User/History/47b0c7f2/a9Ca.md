Ki Stuff

# Intelligent Agents

- Perceives env. through sensors
- Acts on env. through actuators
- paar beispiele in slides

`Agent Function`
- maps any percept sequence to an action

`Percept Sequence`
- complete history of agents perception

## Rational Agent

- rational => does the right thing, has ideal performance
- rationality depends on performance measure, prior knowledge of env., performable actions, percept seq. up to now

--> for each percept seq. agent selects action with maximal perf. measure

`omniscient agent`
 - knows the outcome of its actions - impossible irl
 - rational agent maximizes expected performance

`Learning`
 - rat. agents are able to learn from perception

`Autonomy`
 - more autonomous if less dependent on prior knowledge and uses newly learned stuff instead

## Task Environment
 - **P**erformance **E**nvironment **A**ctuators **S**ensors
 - fully vs partially observable -- if state of env completely detectable or not
 - single vs multi agent -- one or several agents
 - deterministic vs stochastic -- next state fully determined by current state
 - episodic vs sequential -- actions taken in one episode don't affect later ones
 - discrete vs continous -- apply to state and time
 - static vs dynamic -- static if only actions of agents change env
 - known vs unknown -- known if the agent knows outcome of actions

## Agent Types
 `Simple Reflex`
   - e.g. vacuum-cleaner

  `Model-Based Reflex`
   - internal state: agent keeps prev. situation

  `Goal Based`
   - knows current state and considers a goal

   `Utility Based`
   - reaches the goal state with maximum utility

   `Learning`
   - Performance Element
   - learning Element
   - Critic: tells learning element how well agent is doing with respect to a fixed performance measure
   - Problem Generator

---

# Uninformed Search
A search problem can be formaly defined as follows:
 - State Space: set of states
 - Initial Space: starting state
 - Actions
 - Transition Model Result (s,a): returns result after action *a* in state *s*
 - Goal Test Is-Goal(s): true if *s* is a goal state
 - Action Cost c (s,a,s'): cost of applying *a* in *s* to reach *s'*

## Search tree
 - Root - init. state
 - Branches - actions 
 - Nodes - reached states
 - Leaves - unexpanded nodes


## Measuring Problem-Solving Performance

 - Completeness: soluition is foundt if it exists
 - Optimality
 - Time Complexity: How long?
 - Space Complexity: How much memory?

## Uninformed vs. Informed Search

 `Uninformed Search`
  - Only Info provided is problem statement
  - Can only produce next states and check it it's a goal state

 `Informed Search`
  - Know if a state is more promising
  - Uses measurs to indicate goal distance

## Uninformed Search Strategies

**Breadth-First Search**
 - Expand all children of parent nodes in one layer before continuing to next
 - *Completeness:* Yes, if depth d and branching factor b are finite
 - *Optimality:* Yes, if cost is equal per step; not optimal in general
 - *Time Complexity:* Worst case if every node has b successors. Number of explored nodes sums up to BigO(b^d)
 - *Space Complexity:* All explored nodes are BigO(b^{d-1}) and all nodes in the frontier are BigO(b^d)

**Dijkstra (Uniform-Cost Search)**
 - Priority queue for the frontier, ordered by some parametrized eval function f(n): node with minmal value for f(n) is expanded first
 - Different functions f result in different algortihms
 - Uniform-Cost Search is Best-First Search with f(n)=g(n)
 - *Completeness:* Yes, if costs are greater than 0
 - *Optimality:* Yes, if cost >= epsiolon for positive epsilon
 - *Time Complexity:* BigO(b^{1+[C^*/epsilon]})
 - *Space Complexity:* Equals time complexity since all nodes are stored

**Depth-First Search**
 - Expand the deepest node in the frontier
 - goal test on expansion
 - doesn't terminate for infinite state spaces
 - *Completeness:* No, but can be achieved by checking for cycles
 - *Optimality:* No
 - *Time Complexity:* BigO(b^m) iff goal path is tested last
 - *Space Complexity:* advantage of depth first, for m nodes on a leaf and b nodes branching BigO(bm)

**Depth-Limited Search**
 - limit the depth by limit l
 - LIFO Queue for frontier
 - *Completeness:* No, if l < d
 - *Optimality:* No, if l > d
 - *Time Complexity:* BigO(b^l)
 - *Space Complexity:* BigO(bl)

**Iterative Deepening Search**
 - one usualy doesn't know the depth of the goal state -> iteratively increase limit l
 - *Completeness:* Yes if d of goal state is finite
 - *Optimality:* Yes if cost = 1 per step, not in general
 - *Time Complexity:* BigO(b^d)
 - *Space Complexity:* BigO(bd)

**Bidirectional Search**
 - run two searches; one from the initial state and one from the goal
 - requires to "search backwards"
   - easy: if all actions are reversible and there is only one goal
   - difficult: goal state is an abstract description, many goal states exist

---

# Informed Search

 - uses heuristic function *h(n)* to find solutions more effectively
 - *h(n)* gives estimated cost of cheapest path from n.State to goal state
 - *h(n)* is problem-specific with only constraints: beeing nonnegative and h(n^) = 0, where n^ is goal node
 - strategies are best-first but f(n) = h(n)

## Informed Search Strategies

**Greedy Best-First Search**
 - simple best first but f(n) = h(n)
 - *Completeness:* Yes if graph search is used
 - *Optimality:* No
 - *Time Complexity:* BigO(b^m), but improvable by using a good heuristic
 - *Space Complexity:* All nodes are stored so BigO(b^m)

**A*** **Search**
 - f(n) = g(n) + h(n): h(n) has to be admissible
 - heuristic steers search towards goal
 - A* expands nodes in order of increasing f value
 - enormous time savings by pruning - eliminating possibilities without having to examine them
 - *Completeness:* Yes, if costs are greater than 0
 - *Optimality:* Yes, if complete and heuristic is admissible
 - *Time Complexity:* If state space has single goal -> BigO(b^{epsilon d})
 - *Space Complexity:* Equals Time Complexity since all nodes are stored
 - Extensions: 
   - Iterative-deepening A*
   - Recursice best-first search
   - Memory-bounded A*


## Consistent Heuristics
 - a heuristic is consistent if h(n) <= c(n,a,n') + h(n')
 - slightly stronger condition than admissibility
 - every consistent heuristic is admissible
 - a form of general triangle inequality

**Admissibility vs Consistency**
 - Admissible heuristic: Any *goal node* is only expanded if it's on an optimal path
 - Consistent heuristic: Any *node* is only expanded if it's located on an optimal path
 
---

# Constraint Satisfaction Problems


## Difference to standard Search Problems
 - standard: each state is atomic, invisible, has no internal structure
 - CSP: factored representation(set of var, each has a val), goal test is wther each var has val that satisfies all constraints

## Setup
 - tuple(X,D,C)
   - X = {X_1,...,X_n} set of var
   - D = {D_1,...,D_n} set of respective domain vals
   - C = {C_1,...,C_n} set of constraints
 - each D consists of a set of allowed vaues for var X
 - each C consists of a pair <scope,rel> (scope is a touple of vars that participate in C, rel defines possible values as relation)
 - constraint graph as visualization (Node is var, edge connects vars participating in constraint)

## Varieties of Constraints
 - **Unary:** involves sigle var
 - **Binary:** involves pairs of vars
 - **Higher-order:** involves 3 or more
 - **Preferences:** soft constraints -> constraint optimization problem

## Standard Search Formulation
 States are defined as:
  - Initial state
  - Successor function
  - Goal test

## Backtracking Search
 - Depth-first search for CSPs with single-variable assignments
 - basic uninformed algorithm for CSPs
## Variable Selection
 - Minimum Remaining Values - choosing var with fewest possible vals first
 - Degree Heuristic - select var that is involved in the largest number of constraints on other unassigned vars
 - Choosing vars with the minimum number of remeaining vals helps to prune the search tree
## Value Selection
 - Least Constrainig Value - select the value that rules out the fewest coices for neighboring values in the constraint graph
 - We only need one solution; therefore, it makes sense to look at the most likely values first
## Inference
 - Act or process of deriving logical conclusions from known premises
 - can be applied after each assignment or as pre-processing
 - Considered inference techniques:
   - Forward checking (after each assignment): inconsistent values of neighboring vars are removed
   - Arc consistency algorithm (after each assignment or as pre-processing): inconsistent vals of all vars are removed
## Arc Consistency
 - Var X_i is arc-consistent with var X_j, if for every val in the domain D_i exists a value D_j satisfying the binary constraint of the arc(X_i,X_j)
 - A constraint graph is arc-consistent if every var is arc-consistent with every other var
 - Visualization: SLIDES
## Inference
 - Forward Checking
 - Arc Consistency Algorithm

## Tree-Structured CSPs
 - If the constraint graph has no loops, the CSP can be solved in BigO(n d^2) time (n: nr of vars, d: domain size)
 - Compare to general CSPs, where worst-case time is BigO(d^n)
 - This property also applies to logical and probabilistic reasoning

## Nearly tree-structured CSPs
  - Conditioning: instanciate a variable, prune its neighbors domains
  - The value chosen for SA could be wrong, requiring us to try all vals:
    1. Choose a subset of vars S sub X such that the constraint graph becomes a tree after removing S
    2. For each possible constraint-satisfying assignment to variables in S
       1. remove vals from other domains inconsistent with S
       2. if the remaining CSP has a sol, return it with the one of S
  - Size of S isc: runtime BigO(d^c dot (n-c)d^2)
  - For small c, the approach is very fast. Worst case: c >>> n-2
  
---

# Logical Agents
## Knowledge Base
 - A knowledge base is a set of sentences in a formal language
 - possibilities to gain knowledge:
   - Inference
   - Declarative approach
   - perception
 - Agents can be viewed at the
   - knowledge level
   - implementation level 

## Basics of Logic
  - Syntax: Specifies how correct sentences are formed
  - Semantics: defines the meaning of sentences, i.e., when a sentence is true
  - Model: differently defined depending on the discipline. Here, models are instances which evaluate sentences to true or false
  - Satisfaction: if a sentence α is true in a model m, we say that m satisfies α. We use the notation M(α) to describe the set of all models of α
  - Entailment: the relationship between two sentences where the truth of one sentence requires the truth of the other sentence, which is written as α |= β if alpha entails beta. Formally, entailment is defined as α |= β if and only if M(α) ⊆ M(β)

## Syntax of Propositional Logic

The propositional symbols S1, S2, etc, are sentences
  - If S is a sentence, ¬S is a sentence - **negation**
  - If S1 and S2 are sentences, S1 ∧ S2 is a sentence - **conjunction**
  - If S1 and S2 are sentences, S1 ∨ S2 is a sentence - **disjunction**
  - If S1 and S2 are sentences, S1 ⇒ S2 is a sentence - **implication**
  - If S1 and S2 are sentences, S1 ⇔ S2 is a sentence - **biconditional**
  - Backus-Naur Form: S ::= AP|¬S|S1 ∧ S2|S1 ∨ S2|S1 ⇒ S2|S1 ⇔ S2|(S)
  - Operator precedence: ¬, ∧, ∨, ⇒, ⇔

## Semantics of Propositional Logic

Rules for evaluating truth with respect to a model m:
  - ¬S is true iff S is false
  - S1 ∧ S2 is true iff S1 is true and S2 is true
  - S1 ∨ S2 is true iff S1 is true or S2 is true
  - S1 ⇒ S2 is true iff S1 is false or S2 is true, i.e. true iff S1 true and S2 true
  - S1 ⇔ S2 is true iff S1 ⇒ S2 is true and S2 ⇒ S1 is true

## Introduction to theorem proving
 - Instead of using enumeration, we apply rules of inference directly to sentences in theorem proving
 - Theorem prving does not require any models
 - If the number of models is large, but the length of the proof is short, theorem proving can be more efficient than enumeration
 - We require some concepts for theorem proving:
   - Logical equivalence: α and β are logically equivalent if they are true in the same set of models, which is written as α ≡ β := α ≡ β iff α |= β and β |= α
   - Validity: A sentence is valid if it's true in all models (P or not P). Valid sentences are also known as tautologies
   - Satisfiability: A sentence is satisfiable if it's true in some model

## Inference and Proofs
  - Modus Ponens: (α ⇒ β, α)/β -> if alpha => beta and alpha are given, beta can be inferred
  - And-Elimination: (α ∧ β)/α
  - Inference from Equivalences: (α ⇔ β)/((α ⇒ β) ∧(β ⇒ α)) and reverse

## Logical Equivalences
  - (α ∧ β) ≡ (β ∧ α) -> commutativity of ∧
  - (α ∨ β) ≡ (β ∨ α) -> commutativity of ∨
  - ((α ∧ β) ∧ γ) ≡ (α ∧ (β ∧ γ)) -> associativity of ∧
  - ((α ∨ β) ∨ γ) ≡ (α ∨ (β ∨ γ)) -> associativity of ∨
  - ¬(¬α) ≡ α -> double-negation elimination
  - (α ⇒ β) ≡ (¬β ⇒ ¬α) -> contraposition
  - (α ⇒β) ≡ (¬α ∨ β) -> implication elimination
  - (α ⇔β) ≡ ((α ⇒ β) ∧ (β ⇒ α)) -> biconditional elimination
  - ¬(α ∧ β) ≡ (¬α ∨ ¬β) -> De Morgan
  - ¬(α ∨ β) ≡ (¬α ∧ ¬β) -> De Morgan
  - (α ∧ (β ∨ γ)) ≡ ((α ∧ β) ∨ (α ∧ γ)) -> distributivity of ∧ over ∨
  - (α ∨ (β ∧ γ)) ≡ ((α ∨ β) ∧ (α ∨ γ)) -> distributivity of ∨ over ∧

## Automated Theorem Proving
  - Initial state: initial knowledger base
  - Actions: all the inference rules applied to all the sentences that match the top half of the inference rule
  - Result: is to add the sentence in the bottom half of the inference rule
  - Goal: a state that contains the sentence to prove

## Resolution Inference Rules
  - Unit resolution rule: Given literals l_i (ap or its negation) we have that 
   `(l1 ∨ ... ∨ l_k , m)/(l_1 ∨ ... ∨ l_i−1 ∨ l_i+1 ∨ ... ∨ l_k)`,
  where l_i and m are the complementary literals
  - Full resolution rule:  
   `l_1 ∨ ... ∨ l_k , m_1 ∨ ... ∨ m_n)/(l_1 ∨ ... ∨ l_i−1 ∨ l_i +1 ∨ ... ∨ l_k ∨ m_1 ∨ ... ∨ m_j−1 ∨ m_j+1 ∨ ... ∨ m_n)`, 
   where l_i and m_j are complementary literals
  - soundness of the full resolution rule:
    - l_i is true and m_j is false: Hence, m_1 or ... or m_n must be true, because m_1 or...or m_n is given
    - m_j is true nad l_i is false: Hence, l_1 or ... or l_k must be trie, because l_1 or ... or l_k is given
    - l_i is either true or false, so one of these conclusions holds as stated in the resolution rule

## Conjunctive Normal Form
  - resolution rule only applies to disjunction of literals, which are also called clauses
  - every sentence of propositional logic can be reformulated as a conjunction of clauses, which is also referred to as **CNF**
  - **CNF:** A sentence with literals x_ij of the form BigAnd_i BigOr_j (not)x_ij is in conjunctive normal form
  - conversion to cnf
    1. Eliminate  α ⇔ β with (α ⇒ β) ∧ (β ⇒ α)
    2. Eliminate α ⇒ β with ¬α ∨ β
    3. Moving ¬ inwards
    4. use distributivity to swap ∧ and ∨

## A Resolution Algorithm
To show that KB |= α, we show that KB ∧¬α is unsatisfiable.
  1. *KB* ∧ ¬α is converted into CNF
  2. The resolution rules is applied to the resulting clauses: each pair that contains complementary literals is resolved to produce a new clause, which is added to the others (if not already present)
  3. The process continues until
     -  there are no new clauses to be added ⇒ *KB* |= α
     -  two clauses resolve to yield the empty clause ⇒ *KB* |= α

## Completeness of Resolution
  - Resolution Closure: RC(S) of a set of clauses S is the set of all clauses derivable by repeated application of the resolution rule to S and its derivatives
  - RC(S) is finite -> PL-Resolution always terminates
  -Ground resolution theorem: If a set of clauses is unsatisfiable, then the resolution closure of those clauses contains the empty clause

## Horn Clauses
  - proposition symbol; or (conjunction of symbols) ⇒ symbol
  - A knowledge base consisiting of Horn clauses only requires Modus Ponens as an inference method

## AND-OR Graph
  - links joined by an arc indicate a conjunction: every link must be proven
  - links joined without an arc indicate a disjunction: only one link has to be proven

## Backward Chaining
  - Idea: work backwards from the query q -> to prove q by backward chaining  
    - check if q is known already
    - or prove by backward chaining all premises of some rule concluding q
  - Avoid loops: check if new subgoal is already on the goal stack
  - Avoid repeated work

## Forward vs. Backward Chaining
  - Forward chaining
    - data-driven, automativ and unconsciously processing 
    - may do lots of work that is irrelevant to the goal
  - Backward checking
    - goal-driven and appropriate for problem-solving
    - computational effort of backward chaining can be much less than linear in time and space

---

# First-Order Logic

## Advantages and Disadvantages of Propositional Logic
  - Advantages:
    + declarative: pieces of syntax correspond to facts
    + allows partial/disjunctive/negated information
    + compositional -> B_1,1 ∧ P_1,2 is derived from meaning of B_1,1 and of P_1,2
    + meaning is context-independent
  - Disadvantages: 
    - has very limited expressive power

## First-Order Logic (FOL)
  - Objects: nouns in natural language
  - Relations: verbs and adjectives, can be unary or n-ary
  - Functions: relations where each input is related to exactly one output

## Syntax of FOL: Basic Elements
  |Syntactic element | Representation of | Example|
  |---|---|---|
  |Constants | Objects| King John, 2, Tum, ...|
  |Predicates | Relations | Brother, >, ...|
  |Functions | Functions | Sqrt, LeftLegOf, ...|

  |Syntactic element|Examples|
  |---|---|
  |Variables|x, y, a, b, ...|
  |Connectives| ∧, ∨, ¬, ⇒, ⇔|
  |Equality|=|
  |Quantifiers|∀, ∃|

  - Backus-Naur Form: Slides7-9/44

## Terms
  - Backus-Naur Form: Term ::=Function(Term, . . .) | Constant | Variable
  - logical expression that refers to an object
  - Constant symbols are therefore terms, but it's not always convenient to have distinct symbols
  - Term ~= complicated kind of name

## Atomic Sentences
  - Backus-Naur Form: AtomicSentence ::=Predicate | Predicate(Term, ...) | Term = Term
  - formed from a predicate symbol optionally followed by a parenthesized list of terms. predicate := function that returns true|false
  - can have complex terms as arguments
  - can also be formed by using equality (can sinify that terms refer to the same object or to insist hat two terms are not the same object) of terms

## Complex Sentences
  - Backus-Naur Form: Slides 7 15/44
  - we can use logical connectives to construct more complex sentences using the syntax from prop. logics

## ∀ und ∃
### ∀ - Universal Quantifiation
 - kp was ich schreiben soll hier ist ein beispiel: ∀x King(x) ⇒ Person(x).
 - bedeutet All kings are person

### ∃ - Existential Quantification
  - gleiche in greeeeen also beispiel: ∃x Crown(x) ∧ OnHead(x, John)
  - bedeutet john hat eine krone auf dem kopf

### Mistakes to avoid
  - Typically, ⇒ is the main connective with ∀
  - Typically, ∧ is the main connective with ∃

### Scope of Qunatifiers
  - The scope of a quantifier is the range in the formula where the quantifier “engages in”
  - in ∀ x(Crown(x) ∨ (∃x Brother (Richard,x))) the forall has no effect on Brother(Richard,x) -> einf verschiedene vars nutzen

### Nested Quantifiers
  - same type:
    - ∀x ∀y is the same as ∀y ∀x 
    - ∃x ∃y is the same as ∃y ∃x 
  - different type:
    - ∃x ∀y is not the same as ∀y ∃x

### Connctions between Quantifiers
  - Quantifier duality: ∀ and ∃ can be expressed by each other using negation:
    - ∀x Likes(x, IceCream) is equivalent to ¬∃x ¬Likes(x, IceCream)
    - ∃x Likes(x, Broccoli) is equivalent to ¬∀x ¬Likes(x, Broccoli)
  - De Morgan rules for quantified sentences:
    - ∀x ¬P ≡ ¬∃x P
    - ¬∀x P ≡ ∃x ¬P
    - ∀x P ≡ ¬∃x ¬P
    - ∃x P ≡ ¬∀x ¬P

## Assertions and Queries in FOL
  - We add sentences to a knowledge base using Tell, called **assertions**
  - We ask questions of the knowledge base using Ask, called **queries**
  - With AskVars we obtain a stream of answers

## Knowledge Engineering Process
  1. Identify the task
  2. Assemble relevant iknowledge
  3. Decide on vocab of predicates, functions and constants
  4. Encode general knowledge about the domain
  5. Encode a description of the specific problem instance
  6. Pose queries to the inference procedure
  7. Debug knowledge base

---

# Inference in First Order Logic

## Removing Quantifiers in FOL
  - Simple inference rules that remove quantifiers, to convert FOL to propositional logic
  - first forall und dann exists entfernen

### Universal Instantiation
  - UI: we can infer any sentence from substituting a *ground term*(term without var) for the variable
  - one can denote the result of the applied sub θ to the sentence α by Subst(θ, α) so that `(∀v α)/(Subst({v /g }, α))` -- {v/g}:v wird durch g ersetzt
  - glaube beispiel greift am besten hab kp wie ich erklären soll
  
  `∀ x King (x) ∧ Greedy (x) ⇒ Evil (x)` digitieeeert zu
  - `King (John) ∧ Greedy (John) ⇒ Evil (John) King (Richard) ∧ Greedy (Richard) ⇒ Evil (Richard)`
  - `King (Father (John)) ∧ Greedy`
  - `(Father (John)) ⇒ Evil (Father (John))`

  wenn man `{x/John}, {x/Richard}, {x/Father (John)}` tauscht

  - can be applied several times on a knowledge base to add sentences
  - the new kb is equivalent to the old one if
    - all possible subs are performed and the quantified senteces are deleted
    - or new sentences are added and the quantified sentences are kept 

### Existential Instantiation
  - EI: when extistential quantifier appears, we replace a var by a single new constant symbol
  - For any sentence α, variable v , and constant symbol k that does not appear elsewhere in the knowledge base: `(∃v α)/(Subst({v /k}, α))`
  - same here beispiel ist am besten: 
    - `∃x Crown(x) ∧ OnHead(x, John) yields Crown(C1) ∧ OnHead(C1, John)` -> C1 is a new constant symbol, called a Skolem constant
    - `∃x d(x^y)/dy = x^y we obtain d(e^y)/dy = e^y`
  - can be applied once on a kb to replace the existential sentence
  - the new kb is *not* equal to the old one, but is satisiavle iff the old one was (more than one satisfying object might exist)

## Reduction to Propositional Inference
  - Claim: every fol kb can be propositionalized to preserve entailment
  - Idea: Propositionalize KB and query, apply resolution, return res
  - Problem: With function symbols, there arre infinitely many ground terms
  - Theorem: f a sentence α is entailed by a FOL KB, it is entailed by a ﬁnite subset of the propositional KB.
  - Idea: For n = 0 to ∞ do: Create a propositional KB by instantiating with depth-n terms and see if α is entailed by this KB
  - Problem: Works if α is entailed, loops if α is not entailed
  - Theorem: entailment in ﬁrst-order logic is semidecidable - shoutout alan turing <3

## Problems with Propositionalization
  - produces lots of irrelevant sentences
  - with p k-ary predicates and n constants there are p n^k instantiations
  - much worse with funtion symbols

## Generalized Modus Ponens
  - To solve problems -> directly infering sentences in FOL
  - sieht wie folgt aus:
  - For atomic sentences p_i, p'_i and q where there is forall i a substitution θ such that Subst(θ,p'_i) = Subst(θ,p_i), we have that:
  `(p'_1, p'_2,..., p'_n, (p_1 ∧ p_2 ∧ ... ∧ p_n ⇒ q))/(Subst(θ, q))`
  - Bsp:
    - Example: ∀x King(x) ∧ Greedy(x) ⇒ Evil(x), King(John), ∀y Greedy(y)
    - Show that Evil(John): p'_1 is King(John) p_1 is King(x), p'_2 is Greedy(y) p_2 is Greedy(x), q is Evil(x), θ is {x/John, y/John}, Subst(θ,q) is Evil(John)

## Unification
  - Lifted inference rules require finding substitutions that make different logical expressions look identical, called **unification**
  - The unify algorithm Unify(p,q) returns a unifier θ such that Subst(θ,p) = Subst(θ,q) if it exists
  - Examples:
    |p|q|θ|
    |---|---|---|
    |Knows(John,x)|Knows(John,Jane)|{x/Jane}|
    |Knows(John,x)|Knows(y,Elizabeth)|{x/Elizabeth,y/John}|
    |Knows(John,x)|Knows(y,Mother(John))|{x/Mother(John),y/John}|
    |Knows(John,x)|Knows(x,Liz)|fails because x can't be John and Liz at the same time|
  - there always exists a **most general unifier**

## First-Order Horn Clauses
  - Difference in FOL compared to propositional logic is that universally quantified variables are allowed (quantifier is typically omitted)
  - Example: [∀x] King(x) ∧ Greedy(x) ⇒ Evil(x), King(John), [∀y] Greedy(y)

## Forward-Chaining
### Main Idea
  - triggers all the rules whose premises are satisfied and adds their conclusions to the known facts
  - process repeats until the query is answered or no new facts are added
  - a fact is not new if it is just a renaming of an old fact, e.g., Likes(x,IceCream) and Likes(y,IceCream) have identical meaning
  - We introduce Standardize - Apart(r) of a sentence r, which renames all vars withvars that have not been used before to avoid unification issues, such as Unify(Knows(John,x),Knows(x,Elizabeth)) = fail

### Properties 
  - Sound and complete for first-order Horn clauses
  - Forward chaining may not terminate in general if fucntion symbols are involved
  - This is unavoidable: entailment with Horn clauses is semidecidable

## Backward-Chaining
  - The Workhorse for logic programming
  - Uses depth-first recursive proof search so that the following properties are inherited
    - Space is linear in size of proof
    - Incomplete due to infinite loops -> fix by storing intermediate res, resulting in tabled logic progtamming

## Resolution
### CNF for FOL
  - same as in propositional logic, except that literals are allowed to be universally quantified variables
  - every sentence in FOL can be converted into an infernentially equivalent CNF sentence 
  - Conversion:
    - **Eliminate Implications:** replace (α ⇒ β) with (¬α ∨ β)
    - **Move ¬ inwards**
    - **Standardize Vars:** for sentences which use the same var name twice, change the name of one of the vars to avoid confusion when dropping quantifiers
    - **Skolemization:** The process of removing existential quantifiers. Works like *EI* but with skolem functions
    - **Drop universal quantifiers:** just move them to the left and ignore
    - **Distribute ∨ over ∧**

### Inference Rule
  ```
  (l_1 ∨...∨ l_k , m_1 ∨...∨ m_n)/Subst(θ, l_1 ∨...∨ l_i−1 ∨ l_i+1 ∨...∨ l_k ∨ m_1 ∨...∨ m_j−1 ∨ m_j+1 ∨...∨ m_n)
  where Unify(l_i, ¬m_j) = θ
  ```

---

# Bayesian Networks
`Motivation`
  - in many cases, our knowledge about the world is incomplete or uncertain
  - We have to act rationally given uncertain information
## Degrees of Belief
  - We are inly convinced of rules and facts up to a certain degree
  - One option to express the degree of belief is to use probabilities
  - Proabilities subsume the uncertainty caused by the lack of knowledge

## Overview of Probabilistic Methods
  |  |Static Env|Dynamic Env|
  |---|---|---|
  |**Without Actions**|Bayesian networks|Hidden Markov models|
  |**With Actions**|Decision Networks|Markov Decision processes|

## Sample and Event Space
  - **Sample Space:** In probability theory, the set of possible outcomes is called the sample space Ω (Ω={heads,tails} for tossing a coin)
  - **Event Space:** The event space *|F* is the powerset of Ω and contains all possible combinations of outcomes. (*|F*={∅,{heads},{tails},{heads,tails}} for tossing a coin)

## Probability Space
  - consists of:
    - sample space Ω
    - event space *|F*
    - a function *P* that assigns a probability to each event e_i in *|F*, such that 
      1. P(e_i) >= 0
      2. P(e_1 ∪ e_2 ∪ ...) = Sum_i P(e_i) when events e_i in *|F* are mutually exclusive
      3. Sum_ω∈Ω P(ω) = 1

## Random Variable
  - For convenience we introduce a function X:Ω -> *D* from the sample space to some set *D*. We call X a **random var**

## Expectatioin
  - Defined as E(X) = Sum_x∈*D*_x xP(X=x), where *D*_x is the domain of X
  - Result is an avg. outcome over infinitely many experiments

## Multidimensional Random Variable
  - The *joint probability* P((X=x),(Y=y)) refers to the event that X=x and Y=y.
  - **Marginalization:** Probabilities of single vars are obtained using the axiom P(e_1 ∪ e_2 ∪...) = Sum_i P(e_i) for mutually exclusive e_i: P(X=x) = Sum_y∈*D*_y P((X=x),(Y=y))

## Conditional Probability
  - The **conditional probability** that X = x under the condition that is known that Y = y is written and defined as: P((X=x)|(Y=y)) = (P((X=x),(Y=y))/P(Y=y))

## Bayes' Rule
  - Rearranging the conditional probability results in (1) := P((X=x),(Y=y)) = P((X=x)|(Y=y))P(Y=y) and inserting that in P((Y=y)|(X=x)) = (P((X=x)|(Y=y))P(Y=y))/(P(X=x))
  - Summation over all y∈*D*_y in (1) results in: Sum_y∈*D*y P((X=x),(Y=y)) {thaats basically P(X=x)} = Sum_y∈*D*y P((X=x)|(Y=y))P(Y=y) which can be inserted into Bayes rule:
    P((Y=y)|(X=x)) = (P((X=x)|(Y=y))P(Y=y))/(Sum_y ∈*D*y P((X=x)|(Y=y))P(Y=y))