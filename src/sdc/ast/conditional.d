/**
 * Copyright 2010 Bernard Helyer
 * This file is part of SDC. SDC is licensed under the GPL.
 * See LICENCE or sdc.d for more details.
 */
module sdc.ast.conditional;

import sdc.ast.base;
import sdc.ast.expression;
import sdc.ast.sdcmodule;
import sdc.ast.statement;


enum ConditionDeclarationType
{
    Block,
    AlwaysOn
}

class ConditionalDeclaration : Node
{
    ConditionDeclarationType type;
    Condition condition;
    DeclarationDefinition[] thenBlock;
    DeclarationDefinition[] elseBlock;  // Optional.
}

class ConditionalStatement : Node
{
    Condition condition;
    NoScopeNonEmptyStatement thenStatement;
    NoScopeNonEmptyStatement elseStatement;  // Optional.
}

enum ConditionType
{
    Version,
    Debug,
    StaticIf
}

class Condition : Node
{
    ConditionType conditionType;
    Node condition;
}

enum VersionConditionType
{
    Integer,
    Identifier,
    Unittest
}

class VersionCondition : Node
{
    VersionConditionType type;
    IntegerLiteral integer;  // Optional.
    Identifier identifier;  // Optional.
}

enum DebugConditionType
{
    Simple,
    Integer,
    Identifier
}

class DebugCondition : Node
{
    DebugConditionType type;
    IntegerLiteral integer;  // Optional.
    Identifier identifier;  // Optional.
}

class StaticIfCondition : Node
{
    AssignExpression expression;
}