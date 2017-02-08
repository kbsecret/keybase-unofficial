require "open3"
require "json"
require "ostruct"

module Keybase
  # Represents Keybase's JSON chat API.
  class Chat
    CHAT_EXEC_ARGS = ["keybase", "chat", "api"]

    class << self
      def envelope(meth, options: {})
        {
          method: meth,
          params: {
            options: options,
          },
        }.to_json
      end

      # @api private
      def chat_call(payload)
        response = Open3.popen3(*CHAT_EXEC_ARGS) do |stdin, stdout, _, _|
          stdin.write payload
          stdin.close # close after writing to let keybase know we're done
          stdout.read
        end

        JSON.parse response, object_class: OpenStruct
      end

      def list_inbox(topic_type: nil)
        payload = envelope :list, options: {
          topic_type: topic_type,
        }

        chat_call payload
      end

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

      def delete_message(users, id)
        payload = envelope :delete, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
        }

        chat_call payload
      end

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

      def mark_conversation(users, id)
        payload = envelope :mark, options: {
          channel: {
            name: U[*users],
          },
          message_id: id,
        }

        chat_call payload
      end

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
