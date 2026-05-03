import Foundation

@resultBuilder
public struct SchemaBuilder<Object> {
    public static func buildBlock(_ components: AnyField<Object>...) -> [AnyField<Object>] {
        components
    }
}

public func object<Object>(
    @SchemaBuilder<Object> _ build: () -> [AnyField<Object>]
) -> ObjectSchema<Object> {
    ObjectSchema(fields: build())
}
