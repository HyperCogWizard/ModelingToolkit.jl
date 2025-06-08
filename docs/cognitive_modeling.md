# Cognitive Modeling with ModelingToolkit.jl

This document demonstrates the cognitive modeling capabilities added to ModelingToolkit.jl, inspired by OpenCog's symbolic reasoning framework.

## Overview

The cognitive modeling extension provides:
- Symbolic reasoning and inference capabilities
- Advanced AST manipulation for cognitive processes
- Integration with ModelingToolkit's existing symbolic systems
- Pattern recognition and matching in symbolic expressions

## Basic Usage

### Creating a Cognitive System

```julia
using ModelingToolkit

# Create a simple cognitive system
@cognitive my_cognitive_sys

# Or create with initial knowledge and rules
@variables x y z
knowledge_base = [x ~ y + 1, y ~ z * 2]
inference_rules = [InferenceRules.substitution, InferenceRules.symmetry]

cognitive_sys = CognitiveSystem(knowledge_base, inference_rules, :advanced_sys)
```

### Adding Knowledge

```julia
@variables a b c
@cognitive sys

# Add new facts to the knowledge base
add_knowledge!(sys, a ~ b + c)
add_knowledge!(sys, b ~ 2 * c)
```

### Performing Inference

```julia
# Perform inference on a query
@variables x y
query = x
results = infer(sys, query)

# Perform forward reasoning to discover new knowledge
new_facts = reason_forward(sys, max_depth=3)
```

## AST Manipulation

The cognitive module provides advanced Abstract Syntax Tree (AST) manipulation capabilities:

### Analyzing Expression Structure

```julia
@variables x y z
expr = (x + y) * sin(z)

# Get depth and complexity
depth = ast_depth(expr)
complexity = ast_complexity(expr)

# Compare similarity between expressions
expr2 = (a + b) * cos(c)
similarity = ast_similarity(expr, expr2)

# Extract patterns
patterns = ast_patterns(expr)

# Comprehensive cognitive analysis
analysis = cognitive_ast_analysis(expr)
```

### Expression Transformation

```julia
# Define transformation rules
rules = [
    x -> iscall(x) && operation(x) == (+) && 0 in arguments(x) ? 
         sum(filter(arg -> arg != 0, arguments(x))) : x
]

# Apply transformations
optimized = ast_transform(expr, rules)

# Or use built-in optimization
optimized = ast_optimize(expr)
```

## Integration with ModelingToolkit Systems

Connect cognitive systems with regular ModelingToolkit systems for enhanced reasoning:

```julia
# Create a standard MTK system
@variables x(t) y(t)
@parameters p q
using ModelingToolkit: t_nounits as t, D_nounits as D

eqs = [D(x) ~ -p*x + q*y,
       D(y) ~ p*x - q*y]
       
@named mtk_sys = ODESystem(eqs, t, [x, y], [p, q])

# Connect to cognitive system
@cognitive cognitive_sys
connect_to_system(cognitive_sys, mtk_sys)

# Now the cognitive system has knowledge about the MTK system
# and can reason about its structure and properties
```

## Inference Rules

The system comes with several built-in inference rules:

### Modus Ponens
If A → B and A, then infer B

### Transitivity  
If A → B and B → C, then infer A → C

### Symmetry
If A = B, then B = A

### Substitution
If A = B and we have an expression containing A, substitute B

## Example: Reasoning About Dynamical Systems

```julia
@variables x(t) y(t) z(t)
@parameters σ ρ β
using ModelingToolkit: t_nounits as t, D_nounits as D

# Define Lorenz system
eqs = [D(x) ~ σ*(y - x),
       D(y) ~ x*(ρ - z) - y,  
       D(z) ~ x*y - β*z]

@named lorenz = ODESystem(eqs, t)

# Create cognitive system and connect
@cognitive cognitive_lorenz
connect_to_system(cognitive_lorenz, lorenz)

# Add domain-specific knowledge
add_knowledge!(cognitive_lorenz, σ ~ 10.0)
add_knowledge!(cognitive_lorenz, ρ ~ 28.0)
add_knowledge!(cognitive_lorenz, β ~ 8/3)

# Reason about the system
equilibrium_facts = reason_forward(cognitive_lorenz)
```

This cognitive modeling framework enables symbolic reasoning about mathematical models, pattern recognition in complex expressions, and intelligent analysis of dynamical systems.