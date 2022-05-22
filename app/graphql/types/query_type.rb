module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [UserType], null: false, description: 'List of users'
    field :user, Types::UserType, null: true do
      description 'Find a user by ID'
      argument :id, ID, required: true
    end
    field :posts, [PostType], null: false, description: 'List of posts'
    field :comments, [CommentType], null: false, description: 'List of comments'
    field :post, Types::PostType, null: false do
      description 'Find a post by ID'
      argument :id, ID, required: true
    end

    def users
      User.preload(:posts, :comments)
    end

    def user(id:)
      User.find(id)
    end

    def posts
      Post.preload(:comments)
    end

    def post(id:)
      Post.find(id)
    end

    def comments
      Comment.preload(:user)
    end

  end
end
