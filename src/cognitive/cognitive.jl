"""
Cognitive modeling module for ModelingToolkit.jl

Provides cognitive reasoning capabilities inspired by OpenCog and other
symbolic AI frameworks, adapted for scientific modeling and computation.

This module includes:
- Cognitive systems with knowledge bases and inference rules
- AST manipulation for symbolic reasoning
- Pattern recognition and matching
- Forward and backward reasoning
"""

include("core.jl")
include("ast_manipulation.jl")

# Re-export main functionality
export CognitiveSystem, @cognitive, add_knowledge!, infer, reason_forward, 
       connect_to_system, InferenceRules
export SymbolicAST, ast_depth, ast_complexity, ast_similarity, ast_patterns,
       ast_transform, ast_search, ast_substitute_pattern, ast_optimize,
       cognitive_ast_analysis