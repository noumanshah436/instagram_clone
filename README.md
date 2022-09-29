# Instagram Clone

## Modules

### 1. Users
- A user can sign-up and sign-in.
- There should also be the required information in the users table.
- A user can have a display picture

### 2. Posts
- Add all the required information in its table.
- A user can create posts.
- A user can edit/delete his own posts.
- A post can have many images(maximum 10)

### 2. Stories
- A user can add stories.
- A user can delete his own stories.
- A story will remain visible for 24 hours unless deleted by the user.
- Users can see each others’ stories

### 3. Comments
- Add required information in its table.
- A post can have many comments.
- A user can comment on his own product.
- A user can comment on other posts.
- A user can edit/delete any comments on his posts.
- A user can delete any comments on his posts.
- A user can like his/others posts.
### 4. Followers
- Users can follow each other
- User account can be set as private or public
- Private posts only be show when a follow request is accepted by the user

### 5. Search
- There should be a search field in the header of the application from where if a user tries to
search for another user then the list should be populated below the search field and upon
clicking on the option a user should be redirected to its show page.
- You may implement “thinking sphinx” for searching. Or you can use any other full text search
technique (if you use ILIKE/LIKE you must implement a proper TRGM GIN index for full text
search).
