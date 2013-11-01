module Authifer
  module Paths
    def users_path
      "/users"
    end

    def new_user_path
      "#{users_path}/new"
    end

    def sessions_path
      "/sessions"
    end

    def new_session_path
      "#{sessions_path}/new"
    end

    def delete_session_path
      "#{sessions_path}/delete"
    end
  end
end
