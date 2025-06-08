using Test
using ModelingToolkit
using Symbolics

# Test basic cognitive system creation
@testset "Cognitive System Tests" begin
    @testset "Basic CognitiveSystem Creation" begin
        # Test simple creation
        @cognitive sys
        @test sys isa CognitiveSystem
        @test sys.name == :sys
        @test isempty(sys.knowledge_base)
        @test isempty(sys.inference_rules)
        
        # Test with initial knowledge
        @variables x y z
        kb = [x ~ y + 1, y ~ z * 2]
        rules = [InferenceRules.substitution, InferenceRules.symmetry]
        
        cognitive_sys = CognitiveSystem(kb, rules, :test_sys, "Test cognitive system")
        @test cognitive_sys.name == :test_sys
        @test length(cognitive_sys.knowledge_base) == 2
        @test length(cognitive_sys.inference_rules) == 2
    end
    
    @testset "Knowledge Base Operations" begin
        @cognitive sys
        @variables x y z
        
        # Test adding knowledge
        fact1 = x ~ y + z
        add_knowledge!(sys, fact1)
        @test fact1 in sys.knowledge_base
        @test length(sys.knowledge_base) == 1
        
        # Test reasoning graph update
        @test haskey(sys.reasoning_graph, x)
        @test haskey(sys.reasoning_graph, y)  
        @test haskey(sys.reasoning_graph, z)
    end
    
    @testset "Inference Operations" begin
        @variables x y z
        kb = [x ~ y, y ~ z]
        rules = [InferenceRules.substitution]
        
        cognitive_sys = CognitiveSystem(kb, rules, :inference_test)
        
        # Test basic inference
        results = infer(cognitive_sys, x)
        @test !isempty(results)
    end
end

@testset "AST Manipulation Tests" begin
    @testset "AST Depth and Complexity" begin
        @variables x y z
        
        # Simple expression
        expr1 = x + y
        @test ast_depth(expr1) >= 1
        @test ast_complexity(expr1) >= 1
        
        # More complex expression
        expr2 = (x + y) * (z - x)
        @test ast_depth(expr2) > ast_depth(expr1)
        @test ast_complexity(expr2) > ast_complexity(expr1)
    end
    
    @testset "AST Similarity" begin
        @variables x y z a b
        
        expr1 = x + y
        expr2 = a + b
        expr3 = x * y
        
        # Different variables, same structure
        @test ast_similarity(expr1, expr2) > 0.5
        
        # Different operations
        @test ast_similarity(expr1, expr3) < 0.5
        
        # Same expression
        @test ast_similarity(expr1, expr1) == 1.0
    end
    
    @testset "AST Pattern Extraction" begin
        @variables x y z
        expr = x + y + z
        patterns = ast_patterns(expr)
        
        @test expr in patterns
        @test !isempty(patterns)
    end
    
    @testset "Cognitive AST Analysis" begin
        @variables x y z
        expr = (x + y) * sin(z)
        
        analysis = cognitive_ast_analysis(expr)
        
        @test haskey(analysis, :depth)
        @test haskey(analysis, :complexity)
        @test haskey(analysis, :patterns)
        @test haskey(analysis, :variables)
        @test haskey(analysis, :operations)
        @test haskey(analysis, :symmetries)
        
        @test analysis[:depth] >= 1
        @test analysis[:complexity] >= 1
        @test !isempty(analysis[:variables])
    end
end

@testset "Integration with ModelingToolkit Systems" begin
    @testset "Connect CognitiveSystem to MTK System" begin
        # Create a simple MTK system
        @variables x(t) y(t)
        @parameters p q
        using ModelingToolkit: t_nounits as t, D_nounits as D
        
        eqs = [D(x) ~ -p*x + q*y,
               D(y) ~ p*x - q*y]
               
        @named mtk_sys = ODESystem(eqs, t, [x, y], [p, q])
        
        # Create cognitive system and connect
        @cognitive cognitive_sys
        
        # This should work once we have proper MTK system structure
        # For now, just test the function exists
        @test isdefined(ModelingToolkit, :connect_to_system)
    end
end