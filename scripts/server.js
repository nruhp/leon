const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname)); // Serve static files from root

// Navigation Routes
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/leon-ceramics.html');
});

app.get('/contact', (req, res) => {
    res.sendFile(__dirname + '/contact-us.html');
});

app.get('/contact-us', (req, res) => {
    res.sendFile(__dirname + '/contact-us.html');
});

app.get('/custom-manufacturing', (req, res) => {
    res.sendFile(__dirname + '/custom-manufacturing.html');
});

// Contact Form Routes
app.post('/api/contact', async (req, res) => {
    const { name, email, phone, message } = req.body;

    console.log('Received contact form submission:', { name, email, phone, message });

    if (!name || !email || !phone || !message) {
        return res.status(400).json({ success: false, message: 'All fields are required.' });
    }

    try {
        // Configure Transporter
        const transporter = nodemailer.createTransport({
            service: 'gmail', // or your email provider
            auth: {
                user: process.env.EMAIL_USER,
                pass: process.env.EMAIL_PASS
            }
        });

        // Email Options
        const mailOptions = {
            from: process.env.EMAIL_USER,
            to: process.env.EMAIL_USER, // Send to yourself
            replyTo: email,
            subject: `New Contact Form Submission from ${name}`,
            text: `
                Name: ${name}
                Email: ${email}
                Phone: ${phone}
                Message: ${message}
            `,
            html: `
                <h3>New Contact Form Submission</h3>
                <p><strong>Name:</strong> ${name}</p>
                <p><strong>Email:</strong> ${email}</p>
                <p><strong>Phone:</strong> ${phone}</p>
                <p><strong>Message:</strong> ${message}</p>
            `
        };

        // Send Email
        await transporter.sendMail(mailOptions);

        res.status(200).json({ success: true, message: 'Email sent successfully!' });
    } catch (error) {
        console.error('Error sending email:', error);
        res.status(500).json({ success: false, message: 'Failed to send email. Please try again later.' });
    }
});


app.post('/api/partnership', async (req, res) => {
    const { name, company, email, phone, interest, message } = req.body;

    console.log('Received partnership inquiry:', { name, company, email, phone, interest, message });

    if (!name || !email || !phone) {
        return res.status(400).json({ success: false, message: 'Name, Email, and Phone are required.' });
    }

    try {
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL_USER,
                pass: process.env.EMAIL_PASS
            }
        });

        const mailOptions = {
            from: process.env.EMAIL_USER,
            to: process.env.EMAIL_USER,
            replyTo: email,
            subject: `New Partnership Inquiry from ${company || name}`,
            text: `
                Name: ${name}
                Company: ${company || 'N/A'}
                Email: ${email}
                Phone: ${phone}
                Interest: ${interest || 'General'}
                Message: ${message}
            `,
            html: `
                <h3>New Partnership Inquiry</h3>
                <p><strong>Name:</strong> ${name}</p>
                <p><strong>Company:</strong> ${company || 'N/A'}</p>
                <p><strong>Email:</strong> ${email}</p>
                <p><strong>Phone:</strong> ${phone}</p>
                <p><strong>Interest:</strong> ${interest || 'General'}</p>
                <p><strong>Message:</strong> ${message}</p>
            `
        };

        await transporter.sendMail(mailOptions);
        res.status(200).json({ success: true, message: 'Inquiry sent successfully!' });
    } catch (error) {
        console.error('Error sending email:', error);
        res.status(500).json({ success: false, message: 'Failed to send inquiry.' });
    }
});

// Start Server
const server = app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

server.on('error', (e) => {
    console.error('Server error:', e);
});

process.on('exit', (code) => {
    console.log(`Process exited with code: ${code}`);
});

process.on('uncaughtException', (err) => {
    console.error('Uncaught Exception:', err);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});
