import React from "react";

function Stories({ stories }) {
  console.log(stories);
  return (
    <div>
      <h1>These books are from the API</h1>

      {stories.map((story) => {
        return (
          <div key={story.id}>
            <br />
            <img src={story.image.url} alt="" />
            {/* <h2>image: {post.image.url}</h2> */}
          </div>
        );
      })}
    </div>
  );
}

export default Stories;
