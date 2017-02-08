require "open3"
require "json"
require "ostruct"

module Keybase
  # Represents Keybase's JSON chat API.
  class Chat
    # The initial arguments to pass when executing Keybase for chatting.
    CHAT_EXEC_ARGS = ["keybase", "chat", "api"]

    class << self
      # @param meth [Symbol] the chat method
      # @param options [Hash] the options hash
      # @return [String] the JSON serialized envelope
      # @api private
      def envelope(meth, options: {})
        {
          method: meth,
          params: {
            options: options,
          },
        }.to_json
      end

      # @param payload [String]
      # @return [OpenStruct] a struct mapping of the JSON response
      # @api private
      def chat_call(payload)
        response = Open3.popen3(*CHAT_EXEC_ARGS) do |stdin, stdout, _, _|
          stdin.write payload
          stdin.close # close after writing to let keybase know we're done
          stdout.read
        end

        JSON.parse response, object_class: OpenStruct
      end

      # List the user's inbox.
      # @return [OpenStruct] a struct mapping of the JSON response
      def list_inbox(topic_type: nil)
        payload = envelope :list, options: {
          topic_type: topic_type,
        }

        chat_call payload
      end

      # Read a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param peek [Boolean] whether to mark the conversation read
      # @param unread_only [Boolean] whether to fetch unread messages only
      # @return [OpenStruct] a struct mapping of the JSON response
      def conversation(users, peek: false, unread_only: false)
        payload = envelope :read, options: {
          channel: {
            name: U[*users],
          },
          peek: peek,
          unread_only: unread_only,
        }

        chat_call payload
      end

      # Send a message to a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param message [String] the message to send
      # @param public [Boolean] whether to send the message to a public channel
      # @return [OpenStruct] a struct mapping of the JSON response
      def send_message(users, message, public: false)
        payload = envelope :send, options: {
          channel: {
            name: U[*users],
            public: public,
          },
          message: {
            body: message,
          }
        }

        chat_call payload
      end

      # Delete a message from a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param id [Integer] the id of the message to delete
      # @return [OpenStruct] a struct mapping of the JSON response
      def delete_message(users, id)
        payload = envelope :delete, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
        }

        chat_call payload
      end

      # Edit a message in a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param id [Integer] the id of the message to delete
      # @param message [String] the message to send
      # @return [OpenStruct] a struct mapping of the JSON response
      def edit_message(users, id, message)
        payload = envelope :edit, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
          message: {
            body: message,
          }
        }

        chat_call payload
      end

      # Upload a file to a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param path [String] the pathname of the file to upload
      # @param title [String] the uploaded file's title
      # @return [OpenStruct] a struct mapping of the JSON response
      def upload_attachment(users, path, title)
        payload = envelope :attach, options: {
          channel: {
            name: U[*users],
          },
          filename: path,
          title: title,
        }

        chat_call payload
      end

      # Download a file from a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @param id [Integer] the id of the message to download from
      # @param path [String] the pathname to download to
      # @return [OpenStruct] a struct mapping of the JSON response
      def download_attachment(users, id, path)
        payload = envelope :download, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
          output: path,
        }

        chat_call payload
      end

      # Make a conversation as read up to a specific ID.
      # @param users [Array<String>] a list of the users in the conversation
      # @param id [Integer] the id of the message to mark up to
      # @return [OpenStruct] a struct mapping of the JSON response
      def mark_conversation(users, id)
        payload = envelope :mark, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
        }

        chat_call payload
      end

      # Mute a conversation.
      # @param users [Array<String>] a list of the users in the conversation
      # @return [OpenStruct] a struct mapping of the JSON response
      def mute_conversation(users)
        payload = envelope :setstatus, options: {
          channel: {
            name: U[*users],
          },
          status: "muted",
        }

        chat_call payload
      end
    end
  end
end
