import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import BannerImage from "../../images/choosinghouse.svg";
import "./home.css";

const Home = () => {
  return (
    <div className="home-container">
      <div className="hero-section">
        <div className="hero-content">
          <h1 className="hero-title">Find Your Perfect Stay</h1>
          <p className="hero-subtitle">
            Discover unique spaces that feel just like home
          </p>
          <Link to="/rooms">
            <button className="cta-button">
              Explore Rooms
              <span className="arrow">→</span>
            </button>
          </Link>
        </div>
        <div className="hero-image">
          <img src={BannerImage} alt="Room illustration" />
        </div>
      </div>
      <div className="features-section">
        <div className="feature-card">
          <div className="feature-icon">🏠</div>
          <h3>Verified Homes</h3>
          <p>All our properties are carefully vetted for quality</p>
        </div>
        <div className="feature-card">
          <div className="feature-icon">💫</div>
          <h3>Best Prices</h3>
          <p>Find competitive rates for both short and long stays</p>
        </div>
        <div className="feature-card">
          <div className="feature-icon">🔒</div>
          <h3>Secure Booking</h3>
          <p>Your safety and security is our top priority</p>
        </div>
      </div>
    </div>
  );
};

export default Home;
