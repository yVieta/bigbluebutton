import { gql } from '@apollo/client';

const LAST_SEEN_MUTATION = gql`
  mutation UpdateChatUser($chatId: String, $lastSeenAt: bigint) {
    update_chat_user(
      where: { chatId: { _eq: $chatId }, lastSeenAt: { _lt: $lastSeenAt } }
      _set: { lastSeenAt: $lastSeenAt }
    ) {
      affected_rows
    }
  }
`;

export default LAST_SEEN_MUTATION;
