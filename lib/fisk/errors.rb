class Fisk
  module Errors
    class Error < StandardError
    end

    # Raised when a temporary register is released more than once
    class AlreadyReleasedError < Error
    end

    # Raised when a temporary register is used after it has been released
    class UseAfterInvalidationError < Error
    end

    # Raised when a temporary register hasn't been released, but local register
    # allocation was requested
    class UnreleasedRegisterError < Error
    end
  end
end
