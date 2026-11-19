import React, { useState } from 'react';

export interface UserCardItem {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'member' | 'guest';
}

export interface UserCardProps {
  user?: UserCardItem;
  isLoading?: boolean;
  error?: Error | null;
  onEdit?: (user: UserCardItem) => void;
  onRetry?: () => void;
  className?: string;
}

/**
 * UserCard displays user profile information with loading, empty, and error states.
 */
export const UserCard: React.FC<UserCardProps> = ({
  user,
  isLoading = false,
  error = null,
  onEdit,
  onRetry,
  className = '',
}) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  // 1. Loading State (Skeleton)
  if (isLoading) {
    return (
      <div
        role="status"
        aria-label="Loading user profile"
        className={`animate-pulse rounded-lg border border-gray-200 p-4 ${className}`}
      >
        <div className="h-4 w-3/4 rounded bg-gray-200 mb-2" />
        <div className="h-3 w-1/2 rounded bg-gray-200" />
      </div>
    );
  }

  // 2. Error State
  if (error) {
    return (
      <div
        role="alert"
        className={`rounded-lg border border-red-200 bg-red-50 p-4 text-red-800 ${className}`}
      >
        <p className="font-semibold text-sm">Failed to load user</p>
        <p className="text-xs mt-1">{error.message}</p>
        {onRetry && (
          <button
            type="button"
            onClick={onRetry}
            className="mt-2 text-xs font-medium underline hover:text-red-900 focus:outline-none focus:ring-2 focus:ring-red-500 rounded"
          >
            Retry
          </button>
        )}
      </div>
    );
  }

  // 3. Empty State
  if (!user) {
    return (
      <div
        className={`rounded-lg border border-dashed border-gray-300 p-6 text-center text-gray-500 ${className}`}
      >
        <p className="text-sm">No user information available.</p>
      </div>
    );
  }

  // 4. Success / Data State
  return (
    <article
      aria-labelledby={`user-title-${user.id}`}
      className={`rounded-lg border border-gray-200 bg-white p-4 shadow-sm hover:shadow transition-shadow ${className}`}
    >
      <div className="flex items-center justify-between">
        <div>
          <h3 id={`user-title-${user.id}`} className="text-base font-semibold text-gray-900">
            {user.name}
          </h3>
          <p className="text-xs text-gray-500">{user.email}</p>
        </div>
        <span
          className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${
            user.role === 'admin'
              ? 'bg-purple-100 text-purple-800'
              : 'bg-gray-100 text-gray-800'
          }`}
        >
          {user.role}
        </span>
      </div>

      {onEdit && (
        <div className="mt-4 flex justify-end">
          <button
            type="button"
            onClick={() => onEdit(user)}
            aria-label={`Edit ${user.name}`}
            className="rounded bg-indigo-50 px-2.5 py-1.5 text-xs font-semibold text-indigo-600 hover:bg-indigo-100 focus-visible:outline focus-visible:outline-2 focus-visible:outline-indigo-600"
          >
            Edit Profile
          </button>
        </div>
      )}
    </article>
  );
};
