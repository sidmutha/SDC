module sdc.ast.declaration2;

import sdc.location;
import sdc.ast.expression2;
import sdc.ast.identifier2;
import sdc.ast.statement2;
import sdc.ast.type2;

enum DeclarationType {
	Variable,
	Function,
	Template,
	Struct,
	Class,
	Enum,
	Alias,
	AliasThis,
	Import,
	Mixin,
	Linkage,
	StorageClass,
	Conditional,
}

interface Declaration {
	@property
	DeclarationType type();
}

/**
 * Any declaration is a statement
 */
class DeclarationStatement : Statement, Declaration {
	private DeclarationType _type;
	
	@property
	DeclarationType type() {
		return _type;
	}
	
	this(Location location, DeclarationType type) {
		super(location);
		
		_type = type;
	}
}

/**
 * Alias of types
 */
class AliasDeclaration : DeclarationStatement {
	Type type;
	string name;
	
	this(Location location, string name, Type type) {
		super(location, DeclarationType.Alias);
		
		this.name = name;
		this.type = type;
	}
}

/**
 * Alias this
 */
class AliasThisDeclaration : DeclarationStatement {
	Identifier identifier;
	
	this(Location location, Identifier identifier) {
		super(location, DeclarationType.AliasThis);
		
		this.identifier = identifier;
	}
}

/**
 * Variables declaration
 */
class VariablesDeclaration : DeclarationStatement {
	Type type;
	Expression[string] variables;
	
	this(Location location, Expression[string] variables, Type type) {
		super(location, DeclarationType.Variable);
		
		this.type = type;
		this.variables = variables;
	}
}

/**
 * Function Declaration
 */
class FunctionDeclaration : DeclarationStatement {
	string name;
	Type returnType;
	Parameter[] parameters;
	
	this(Location location, string name, Type returnType, Parameter[] parameters) {
		super(location, DeclarationType.Function);
		
		this.name = name;
		this.returnType = returnType;
		this.parameters = parameters;
	}
}

/**
 * Function Definition
 */
class FunctionDefinition : FunctionDeclaration {
	Statement fbody;
	
	this(Location location, string name, Type returnType, Parameter[] parameters, Statement fbody) {
		super(location, name, returnType, parameters);
		
		this.fbody = fbody;
	}
}

/**
 * Constructor Declaration
 */
class ConstructorDeclaration : DeclarationStatement {
	Parameter[] parameters;
	
	this(Location location, Parameter[] parameters) {
		super(location, DeclarationType.Function);
		
		this.parameters = parameters;
	}
}

/**
 * Constructor Definition
 */
class ConstructorDefinition : ConstructorDeclaration {
	Statement fbody;
	
	this(Location location, Parameter[] parameters, Statement fbody) {
		super(location, parameters);
		
		this.fbody = fbody;
	}
}

/**
 * Destructor Declaration
 */
class DestructorDeclaration : DeclarationStatement {
	Parameter[] parameters;
	
	this(Location location, Parameter[] parameters) {
		super(location, DeclarationType.Function);
		
		this.parameters = parameters;
	}
}

/**
 * Destructor Definition
 */
class DestructorDefinition : DestructorDeclaration {
	Statement fbody;
	
	this(Location location, Parameter[] parameters, Statement fbody) {
		super(location, parameters);
		
		this.fbody = fbody;
	}
}

/**
 * Struct Declaration
 */
class StructDeclaration : DeclarationStatement {
	string name;
	
	this(Location location, string name) {
		super(location, DeclarationType.Struct);
		
		this.name = name;
	}
}

/**
 * Struct Definition
 */
class StructDefinition : StructDeclaration {
	Declaration[] members;
	
	this(Location location, string name, Declaration[] members) {
		super(location, name);
		
		this.members = members;
	}
}

/**
 * Class Definition
 */
class ClassDefinition : DeclarationStatement {
	string name;
	Identifier[] bases;
	Declaration[] members;
	
	this(Location location, string name, Identifier[] bases, Declaration[] members) {
		super(location, DeclarationType.Class);
		
		this.name = name;
		this.bases = bases;
		this.members = members;
	}
}

/**
 * Import declaration
 */
class ImportDeclaration : DeclarationStatement {
	string name;
	Identifier[] modules;
	
	this(Location location, Identifier[] modules) {
		super(location, DeclarationType.Import);
		
		this.modules = modules;
	}
}

import sdc.token;
enum StorageClass {
	Abstract = TokenType.Abstract,
	Const = TokenType.Const,
	Deprecated = TokenType.Deprecated,
	Immutable = TokenType.Immutable,
	Inout = TokenType.Inout,
	Shared = TokenType.Shared,
	Nothrow = TokenType.Nothrow,
	Override = TokenType.Override,
	Pure = TokenType.Pure,
	Static = TokenType.Static,
	Synchronized = TokenType.Synchronized,
}

/**
 * Storage class declaration
 */
class StorageClassDeclaration(StorageClass storageClass) : DeclarationStatement {
	Declaration[] declarations;
	
	this(Location location, Declaration[] declarations) {
		super(location, DeclarationType.StorageClass);
		
		this.declarations = declarations;
	}
}

alias StorageClassDeclaration!(StorageClass.Abstract) AbstractDeclaration;
alias StorageClassDeclaration!(StorageClass.Deprecated) DeprecatedDeclaration;
alias StorageClassDeclaration!(StorageClass.Nothrow) NothrowDeclaration;
alias StorageClassDeclaration!(StorageClass.Override) OverrideDeclaration;
alias StorageClassDeclaration!(StorageClass.Pure) PureDeclaration;
alias StorageClassDeclaration!(StorageClass.Static) StaticDeclaration;
alias StorageClassDeclaration!(StorageClass.Synchronized) SynchronizedDeclaration;

/**
 * Linkage declaration
 */
class LinkageDeclaration : DeclarationStatement {
	string linkage;
	Declaration[] declarations;
	
	this(Location location, string linkage, Declaration[] declarations) {
		super(location, DeclarationType.Linkage);
		
		this.linkage = linkage;
		this.declarations = declarations;
	}
}

